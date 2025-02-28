
Client
======

:edb-alt-title: Client Library

This is the core client library, providing the main :ref:`createClient() <gel-dart-createClient>`
function for configuring a connection to an Gel server, and the :ref:`Client <gel-dart-Client>`
class, which implements all the methods to run queries, work with
transactions, and manage other client state.

Parameters​
-----------

If your query contains parameters (e.g. ``$foo``), you can pass in values as
the second argument to all the ``execute()`` and ``query*()`` methods.

Named parameters are expected to be passed as a ``Map<String, dynamic>``, and
positional parameters as a ``List<dynamic>``.

.. code-block:: dart

    // Named parameters
    await client.execute(r'''insert Movie {
      title := <str>$title
    }''', {'title': 'Iron Man'});
    
    // Positional parameters
    await client.execute(r'''insert Movie {
      title := <str>$0
    }''', ['Iron Man']);
    
Remember that `parameters </reference/edgeql/parameters#parameter-types-and-json>`__
can only be scalars or arrays of scalars.

Scripts​
--------

All the ``execute()`` and the ``query*()`` methods support scripts (queries
containing multiple statements). The statements are run in an implicit
transaction (unless already in an explicit transaction), so the whole
script remains atomic. For the ``query*()`` methods only the result of the
final statement in the script will be returned.

.. code-block:: dart

    final result = await client.query(r'''
      insert Movie {
        title := <str>$title
      };
      insert Person {
        name := <str>$name
      };
    ''', {
      'title': 'Thor: Ragnarok',
      'name': 'Anson Mount'
    });
    // [{id: "5dd2557b..."}]
    // Note: only the single item of the `insert Person ...`
    // statement is returned
    
For more fine grained control of atomic exectution of multiple statements,
use the :ref:`Client.transaction() <gel-dart-Client-transaction>` API.

Type Conversion
---------------

Gel types are decoded into/encoded from Dart types as follows (any types
in parentheses are also valid for query parameters):

.. list-table::
  :header-rows: 1

  * - Gel type
    - Dart type
  * - Sets
    - `List\<dynamic\> <https://api.dart.dev/stable/3.7.1/dart-core/List-class.html>`__
  * - Arrays
    - `List\<dynamic\> <https://api.dart.dev/stable/3.7.1/dart-core/List-class.html>`__
  * - Objects
    - `Map\<String, dynamic\> <https://api.dart.dev/stable/3.7.1/dart-core/Map-class.html>`__
  * - Tuples (``tuple<x, y, ...>``)
    - `List\<dynamic\> <https://api.dart.dev/stable/3.7.1/dart-core/List-class.html>`__
  * - Named tuples (``tuple<foo: x, bar: y, ...>``)
    - `Map\<String, dynamic\> <https://api.dart.dev/stable/3.7.1/dart-core/Map-class.html>`__
  * - Ranges
    - :ref:`Range\<dynamic\> <gel-dart-Range>`
  * - Multiranges
    - :ref:`MultiRange\<dynamic\> <gel-dart-MultiRange>`
  * - Enums
    - `String <https://api.dart.dev/stable/3.7.1/dart-core/String-class.html>`__
  * - ``str``
    - `String <https://api.dart.dev/stable/3.7.1/dart-core/String-class.html>`__
  * - ``bool``
    - `bool <https://api.dart.dev/stable/3.7.1/dart-core/bool-class.html>`__
  * - ``int16``/``int32``/``int64``
    - `int <https://api.dart.dev/stable/3.7.1/dart-core/int-class.html>`__
  * - ``float32``/``float64``
    - `double <https://api.dart.dev/stable/3.7.1/dart-core/double-class.html>`__
  * - ``json``
    - as decoded by ``json.decode()``
  * - ``uuid``
    - `String <https://api.dart.dev/stable/3.7.1/dart-core/String-class.html>`__
  * - ``bigint``
    - `BigInt <https://api.dart.dev/stable/3.7.1/dart-core/BigInt-class.html>`__
  * - ``decimal``
    - *(unsupported)*
  * - ``bytes``
    - `Uint8List <https://api.dart.dev/stable/3.7.1/dart-typed_data/Uint8List-class.html>`__
  * - ``datetime``
    - `DateTime <https://api.dart.dev/stable/3.7.1/dart-core/DateTime-class.html>`__
  * - ``duration``
    - `Duration <https://api.dart.dev/stable/3.7.1/dart-core/Duration-class.html>`__
  * - ``cal::local_datetime``
    - `LocalDateTime <https://pub.dev/documentation/gel/latest/gel/LocalDateTime-class.html>`__
  * - ``cal::local_date``
    - `LocalDate <https://pub.dev/documentation/gel/latest/gel/LocalDate-class.html>`__
  * - ``cal::local_time``
    - `LocalTime <https://pub.dev/documentation/gel/latest/gel/LocalTime-class.html>`__
  * - ``cal::relative_duration``
    - `RelativeDuration <https://pub.dev/documentation/gel/latest/gel/RelativeDuration-class.html>`__
  * - ``cal::date_duration``
    - `DateDuration <https://pub.dev/documentation/gel/latest/gel/DateDuration-class.html>`__
  * - ``cfg::memory``
    - :ref:`ConfigMemory <gel-dart-ConfigMemory>`
  * - ``ext::pgvector::vector``
    - `Float32List <https://api.dart.dev/stable/3.7.1/dart-typed_data/Float32List-class.html>`__ (`List\<double\> <https://api.dart.dev/stable/3.7.1/dart-core/List-class.html>`__)

Custom types
------------

For Gel types that don't have a built-in Dart type, we provide some
custom types:


* `LocalDateTime <https://pub.dev/documentation/gel/latest/gel/LocalDateTime-class.html>`__

* `LocalDate <https://pub.dev/documentation/gel/latest/gel/LocalDate-class.html>`__

* `LocalTime <https://pub.dev/documentation/gel/latest/gel/LocalTime-class.html>`__

* `RelativeDuration <https://pub.dev/documentation/gel/latest/gel/RelativeDuration-class.html>`__

* `DateDuration <https://pub.dev/documentation/gel/latest/gel/DateDuration-class.html>`__

* :ref:`Range <gel-dart-Range>`

* :ref:`ConfigMemory <gel-dart-ConfigMemory>`

Gel errors
----------

Gel has a large range of type errors for fine-grained error handling,
with all exported error types inheriting from a base `GelError <https://pub.dev/documentation/gel/latest/gel/GelError-class.html>`__ type.
These are the main error types which are useful to watch out for (along
with their subtypes):


* `QueryError <https://pub.dev/documentation/gel/latest/gel/QueryError-class.html>`__: Errors relating to an issue with the query you're trying
  to run, such as syntax errors, or non-existant types/properties/links.

* `ExecutionError <https://pub.dev/documentation/gel/latest/gel/ExecutionError-class.html>`__: Runtime errors while running your query, such as
  cardinality violations.

* `ClientError <https://pub.dev/documentation/gel/latest/gel/ClientError-class.html>`__: Client side errors arising from incorrect arguments being
  passed to methods, etc.

* `AccessError <https://pub.dev/documentation/gel/latest/gel/AccessError-class.html>`__: The authentication details you provided were incorrect.

* `InternalServerError <https://pub.dev/documentation/gel/latest/gel/InternalServerError-class.html>`__: Ideally these should never happen; they indicate a
  bug in the Gel server. It's useful if you can
  report these errors here: `github.com/geldata/gel/issues <https://github.com/geldata/gel/issues>`__
