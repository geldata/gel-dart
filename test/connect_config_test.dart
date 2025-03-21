import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:gel/src/connect_config.dart';
import 'package:gel/src/errors/base.dart';
import 'package:gel/src/platform.dart';
import 'package:gel/src/utils/env.dart';
import 'package:gel/src/utils/parse_duration.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

import '_io_mocks.dart';

void main() {
  test("parseConnectArguments", () async {
    dynamic connectionTestcases;
    try {
      connectionTestcases = jsonDecode(
          await File("./test/shared-client-testcases/connection_testcases.json")
              .readAsString());
    } catch (err) {
      throw Exception('Failed to read "connection_testcases.json": $err.\n'
          'Is the "shared-client-testcases" submodule initialised? '
          'Try running "git submodule update --init".');
    }

    Map<String, dynamic> exceptions = {};

    for (var testcase in connectionTestcases) {
      try {
        await runConnectionTest(testcase);
      } catch (err) {
        exceptions[testcase['name']] = err;
      }
    }

    if (exceptions.isNotEmpty) {
      throw Exception('''${exceptions.length} connection testcases failed:

${exceptions.entries.map((e) => '--- ${e.key} ---\n${e.value}').join('\n\n')}''');
    }
  });

  test("project path hashing", () async {
    dynamic hashingTestcases;
    try {
      hashingTestcases = jsonDecode(await File(
              './test/shared-client-testcases/project_path_hashing_testcases.json')
          .readAsString());
    } catch (err) {
      throw Exception(
          'Failed to read "project_path_hashing_testcases.json": $err.\n'
          'Is the "shared-client-testcases" submodule initialised? '
          'Try running "git submodule update --init".');
    }

    for (var testcase in hashingTestcases) {
      if (testcase['platform'] == Platform.operatingSystem) {
        await runWithEnv(
            env: testcase['env'] != null ? Map.castFrom(testcase['env']) : {},
            homedir: testcase['homeDir'] as String?, () async {
          expect(await searchConfigDir(await getStashPath(testcase['project'])),
              testcase['result']);
        });
      }
    }
  });

  test("GEL_CLIENT_SECURITY env var", () async {
    final truthTable = [
      // CLIENT_SECURITY, CLIENT_TLS_SECURITY, result
      ["default", TLSSecurity.defaultSecurity, TLSSecurity.defaultSecurity],
      ["default", TLSSecurity.insecure, TLSSecurity.insecure],
      [
        "default",
        TLSSecurity.noHostVerification,
        TLSSecurity.noHostVerification
      ],
      ["default", TLSSecurity.strict, TLSSecurity.strict],
      ["insecure_dev_mode", TLSSecurity.defaultSecurity, TLSSecurity.insecure],
      ["insecure_dev_mode", TLSSecurity.insecure, TLSSecurity.insecure],
      [
        "insecure_dev_mode",
        TLSSecurity.noHostVerification,
        TLSSecurity.noHostVerification
      ],
      ["insecure_dev_mode", TLSSecurity.strict, TLSSecurity.strict],
      ["strict", TLSSecurity.defaultSecurity, TLSSecurity.strict],
      ["strict", TLSSecurity.insecure, null],
      ["strict", TLSSecurity.noHostVerification, null],
      ["strict", TLSSecurity.strict, TLSSecurity.strict],
    ];

    for (var item in truthTable) {
      await runWithEnv(env: {'GEL_CLIENT_SECURITY': item[0] as String},
          () async {
        final parseConnectArgs = parseConnectConfig(ConnectConfig(
            host: 'localhost', tlsSecurity: item[1] as TLSSecurity));
        if (item[2] == null) {
          await expectLater(parseConnectArgs, throwsA(isA()));
        } else {
          expect(debugGetRawTlsSecurity(await parseConnectArgs), item[2]);
        }
      });
    }
  });
}

final errorMapping = {
  'credentials_file_not_found': RegExp(r"^cannot read credentials file"),
  'project_not_initialised': RegExp(
      r"^Found 'gel\.toml' \(or 'edgedb\.toml'\) but the project is not initialized"),
  'no_options_or_toml': RegExp(
      r"^no 'gel\.toml' \(or 'edgedb\.toml'\) found and no connection options specified either"),
  'invalid_credentials_file': RegExp(r"^cannot read credentials file"),
  'invalid_dsn_or_instance_name': RegExp(r"^invalid DSN or instance name"),
  'invalid_dsn': RegExp(r"^invalid DSN"),
  'invalid_instance_name': RegExp(r"^invalid instance name"),
  'unix_socket_unsupported': RegExp(r"^unix socket paths not supported"),
  'invalid_port': RegExp(r"^invalid port"),
  'invalid_host': RegExp(r"^invalid host"),
  'invalid_user': RegExp(r"^invalid user"),
  'invalid_database': RegExp(r"^invalid database"),
  'multiple_compound_opts':
      RegExp(r"^Cannot have more than one of the following connection options"),
  'multiple_compound_env': RegExp(
      r"^Cannot have more than one of the following connection environment variables"),
  'env_not_found': RegExp(r"environment variable '.*' doesn't exist"),
  'file_not_found': RegExp(r"cannot open file"),
  'invalid_tls_security': RegExp(
      r"^invalid 'tlsSecurity' value|'tlsSecurity' value cannot be lower than security level set by (GEL|EDGEDB)_CLIENT_SECURITY"),
  'exclusive_options':
      RegExp(r"^Cannot specify both .* and .*|are mutually exclusive"),
  'secret_key_not_found':
      RegExp(r"^Cannot connect to cloud instances without a secret key"),
  'invalid_secret_key': RegExp(r"^Invalid secret key"),
};

Future<void> runConnectionTest(Map<String, dynamic> testcase) async {
  final Map<String, String> env =
      testcase['env'] != null ? Map.castFrom(testcase['env']) : {};
  final fs = testcase['fs'];
  final platform = testcase['platform'] as String?;
  final opts = testcase['opts'];

  if (opts?['port'] is double) {
    expect(testcase['error']?['type'], 'invalid_port');
    return;
  }
  if (opts?['port'] is String) {
    try {
      opts['port'] = int.parse(opts['port']);
    } catch (e) {
      expect(testcase['error']?['type'], 'invalid_port');
      return;
    }
  }
  if (opts?['tlsSecurity'] != null &&
      !tlsSecurityValues.containsKey(opts?['tlsSecurity'])) {
    expect(testcase['error']?['type'], 'invalid_tls_security');
    return;
  }
  if (opts?['waitUntilAvailable'] is String) {
    opts['waitUntilAvailable'] = parseDuration(opts['waitUntilAvailable']);
  }

  final config = ConnectConfig.fromJson({
    ...(opts ?? {}),
    'instanceName': opts?['instance'],
  });

  if (fs != null &&
      ((platform == null && (Platform.isWindows || Platform.isMacOS)) ||
          (platform == "windows" && !Platform.isWindows) ||
          (platform == "macos" && !Platform.isMacOS))) {
    return;
  }

  if (testcase.containsKey('error')) {
    final error = errorMapping[testcase['error']['type']];
    if (error == null) {
      throw Exception('Unknown error type: ${testcase['error']['type']}');
    }
    await expectLater(
        runWithEnv(
            env: env,
            homedir: fs?['homedir'] as String?,
            cwd: fs?['cwd'] as String?,
            files: fs?['files'] != null ? Map.castFrom(fs?['files']) : null,
            () => parseConnectConfig(config)),
        throwsA(isA<GelError>()
            .having((e) => e.message, 'message', matches(error))));
  } else {
    await runWithEnv(
        env: env,
        homedir: fs?['homedir'] as String?,
        cwd: fs?['cwd'] as String?,
        files: fs?['files'] != null ? Map.castFrom(fs?['files']) : null,
        () async {
      final params = await parseConnectConfig(config);
      final result = (testcase['result'] as Map<String, dynamic>)
        ..remove('tlsServerName');
      expect({
        'address': [params.address.host, params.address.port],
        'database': params.database,
        'branch': params.branch,
        'user': params.user,
        'password': params.password,
        'secretKey': params.secretKey,
        'tlsCAData': debugGetRawCAData(params),
        'tlsSecurity': params.tlsSecurity.value,
        // 'tlsServerName': null, // TODO: Properly handle server name option
        'serverSettings': params.serverSettings..remove('tls_server_name'),
        'waitUntilAvailable': params.waitUntilAvailable,
      }, {
        ...result,
        'waitUntilAvailable':
            parseISODurationString(testcase['result']['waitUntilAvailable'])
                .inMilliseconds,
      });
    });
    // TODO: check warnings
    // if (testcase.warnings) {
    //   for (const warntype of testcase.warnings) {
    //     const warning = warningMapping[warntype];
    //     if (!warning) {
    //       throw new Error(`Unknown warning type: ${warntype}`);
    //     }
    //     expect(warnings).toContainEqual(warning);
    //   }
    // }
  }
}

String hashProjectPath(String projectPath) {
  if (Platform.isWindows && !projectPath.startsWith("\\\\")) {
    projectPath = "\\\\?\\$projectPath";
  }

  return sha1.convert(utf8.encode(projectPath)).toString();
}

Future<void> runWithEnv(Future<void> Function() body,
    {Map<String, String>? env,
    String? cwd,
    String? homedir,
    Map<String, dynamic>? files}) async {
  final mockedFiles = <String, String>{};
  if (files != null) {
    for (var entry in files.entries) {
      if (entry.value is String) {
        mockedFiles[entry.key] = entry.value;
      } else {
        final filepath = entry.key.replaceAll(
            r'${HASH}', hashProjectPath(entry.value['project-path']));
        mockedFiles[filepath] = '';
        for (var entry in entry.value.entries) {
          mockedFiles[join(filepath, entry.key)] = entry.value;
        }
      }
    }
  }
  await IOOverrides.runZoned(() async {
    if (env != null || homedir != null) {
      setEnvOverrides({
        ...(env ?? Platform.environment),
        if (homedir != null) 'HOME': homedir
      });

      try {
        await body();
      } finally {
        clearEnvOverrides();
      }
    }
  },
      getCurrentDirectory: cwd != null ? () => Directory(cwd) : null,
      createFile: files != null
          ? (String path) => FileMock(path, mockedFiles[path])
          : null,
      createDirectory: (String path) => DirectoryMock(path));
}
