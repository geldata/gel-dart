import 'package:gel/gel.dart';

import 'selectScalarNeedsImport.edgeql.dart';

void main() async {
  final client = createClient();

  try {
    await client.selectScalarNeedsImport();
  } finally {
    await client.close();
  }
}
