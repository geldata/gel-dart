import 'dart:convert';
import 'dart:io';

const tagMapping = {
  'SHOULD_RETRY': 'shouldRetry',
  'SHOULD_RECONNECT': 'shouldReconnect'
};

main() async {
  final json = await Process.run('edb', ['gen-errors-json', '--client']);
  final errors = jsonDecode(json.stdout.toString());

  final errorsBuf = StringBuffer();
  errorsBuf
    ..writeln('// AUTOGENERATED')
    ..writeln('// ignore_for_file: overridden_fields')
    ..writeln()
    ..writeln('import \'base.dart\';')
    ..writeln()
    ..writeln('export \'base.dart\' show GelError, GelErrorTag;')
    ..writeln();

  final mappingBuf = StringBuffer();
  mappingBuf
    ..writeln('// AUTOGENERATED')
    ..writeln()
    ..writeln('import \'errors.dart\';')
    ..writeln()
    ..writeln('final errorMapping = {');

  for (var err in errors) {
    final base = err[1] ?? 'GelError';

    final code = '0x${err[2].toRadixString(16).padLeft(2, '0')}'
        '${err[3].toRadixString(16).padLeft(2, '0')}'
        '${err[4].toRadixString(16).padLeft(2, '0')}'
        '${err[5].toRadixString(16).padLeft(2, '0')}';

    errorsBuf
      ..writeln('class ${err[0]} extends $base {')
      ..writeln('  ${err[0]}(super.message, [super.source]);')
      ..writeln()
      ..writeln('  ${err[1] != null ? '@override ' : ''}final code = $code;');

    final tagItems = err[6] as List<dynamic>;
    if (tagItems.isNotEmpty) {
      errorsBuf
        ..writeln()
        ..writeln('  @override final tags = '
            '{${tagItems.map((e) => 'GelErrorTag.${tagMapping[e]}').join(', ')}};');
    }
    errorsBuf
      ..writeln('}')
      ..writeln();

    mappingBuf.writeln('  $code: ${err[0]}.new,');
  }

  mappingBuf.writeln('};');

  await File('lib/src/errors/errors.dart').writeAsString(errorsBuf.toString());
  await File('lib/src/errors/map.dart').writeAsString(mappingBuf.toString());
  await Process.run('dart', ['format', 'lib/src/errors/errors.dart']);
  await Process.run('dart', ['format', 'lib/src/errors/map.dart']);
}
