
API
===

:edb-alt-title: Client API Reference


.. _gel-dart-createClient:

*function* createClient()
-------------------------

.. code-block:: dart

    Client createClient({ 
      String? dsn, 
      String? instanceName, 
      String? credentials, 
      String? credentialsFile, 
      String? host, 
      int? port, 
      String? database, 
      String? branch, 
      String? user, 
      String? password, 
      String? secretKey, 
      Map<String, String>? serverSettings, 
      String? tlsCA, 
      String? tlsCAFile, 
      TLSSecurity? tlsSecurity, 
      Duration? waitUntilAvailable, 
      ConnectConfig? config, 
      int? concurrency, }
    )

Creates a new :ref:`Client <gel-dart-Client>` instance with the provided connection options.

Usually it's recommended to not pass any connection options here, and
instead let the client resolve the connection options from the Gel
project or environment variables. See the
`Client Library Connection </reference/reference/connection>`__
documentation for details on connection options and how they are
resolved.

The ``config`` parameter allows you to pass in a `ConnectConfig <https://pub.dev/documentation/gel/latest/gel/ConnectConfig-class.html>`__ object, which
is just a wrapper object containing connection options to make them easier
to manage in your application. If a connection option exists both in the
``config`` object and is passed as a parameter, the value passed as a
parameter will override the value in the ``config`` object.

Alongside the connection options, there are the following parameters:


* ``concurrency``: Specifies the maximum number of connections the :ref:`Client <gel-dart-Client>`
  will create in it's connection pool. If not specified the
  concurrency will be controlled by the server. This is
  recommended as it allows the server to better manage the
  number of client connections based on it's own available
  resources.

.. _gel-dart-Client:

*class* Client
--------------

Represents a pool of connections to the database, provides methods to run
queries and manages the context in which queries are run (ie. setting
globals, modifying session config, etc.)

The :ref:`Client <gel-dart-Client>` class cannot be instantiated directly, and is instead created
by the :ref:`createClient() <gel-dart-createClient>` function. Since creating a client is relatively
expensive, it is recommended to create a single :ref:`Client <gel-dart-Client>` instance that you
can then import and use across your app.

The ``with*()`` methods return a new :ref:`Client <gel-dart-Client>` instance derived from this
instance. The derived instances all share the pool of connections managed
by the root :ref:`Client <gel-dart-Client>` instance (ie. the instance created by :ref:`createClient() <gel-dart-createClient>`),
so calling the :ref:`ensureConnected() <gel-dart-Client-ensureConnected>`, :ref:`close() <gel-dart-Client-close>` or :ref:`terminate() <gel-dart-Client-terminate>` methods on
any of these instances will affect them all.

.. _gel-dart-Client-isClosed:

*property* ``.isClosed``
........................


.. code-block:: dart

    bool get isClosed

Whether :ref:`close() <gel-dart-Client-close>` (or :ref:`terminate() <gel-dart-Client-terminate>`) has been called on the client.
If :ref:`isClosed <gel-dart-Client-isClosed>` is ``true``, subsequent calls to query methods will fail.

.. _gel-dart-Client-close:

*method* ``.close()``
.....................


.. code-block:: dart

    Future<void> close()

Close the client's open connections gracefully.

Returns a ``Future`` that completes when all connections in the client's
pool have finished any currently running query. Any pending queries
awaiting a free connection from the pool, and have not started executing
yet, will return an error.

A warning is produced if the pool takes more than 60 seconds to close.

.. _gel-dart-Client-ensureConnected:

*method* ``.ensureConnected()``
...............................


.. code-block:: dart

    Future<void> ensureConnected()

If the client does not yet have any open connections in its pool,
attempts to open a connection, else returns immediately.

Since the client lazily creates new connections as needed (up to the
configured ``concurrency`` limit), the first connection attempt will
usually only happen when the first query is run on a client.
The :ref:`ensureConnected() <gel-dart-Client-ensureConnected>` method allows you to explicitly check that the
client can connect to the database without running a query
(can be useful to catch any errors resulting from connection
mis-configuration).

.. _gel-dart-Client-execute:

*method* ``.execute()``
.......................


.. code-block:: dart

    Future<void> execute( 
      String query, [
      dynamic args]
    )

Executes a query, returning no result.

For details on ``args`` see the ``gel`` library
`docs page <https://pub.dev/documentation/gel/latest/gel>`__.

.. _gel-dart-Client-executeSQL:

*method* ``.executeSQL()``
..........................


.. code-block:: dart

    Future<void> executeSQL( 
      String query, [
      dynamic args]
    )

Executes a SQL query, returning no result.

For details on ``args`` see the ``gel`` library
`docs page <https://pub.dev/documentation/gel/latest/gel>`__.

.. _gel-dart-Client-query:

*method* ``.query()``
.....................


.. code-block:: dart

    Future<List> query( 
      String query, [
      dynamic args]
    )

Executes a query, returning a ``List`` of results.

For details on result types and ``args`` see the ``gel`` library
`docs page <https://pub.dev/documentation/gel/latest/gel>`__.

.. _gel-dart-Client-queryJSON:

*method* ``.queryJSON()``
.........................


.. code-block:: dart

    Future<String> queryJSON( 
      String query, [
      dynamic args]
    )

Executes a query, returning the result as a JSON encoded ``String``.

For details on ``args`` see the ``gel`` library
`docs page <https://pub.dev/documentation/gel/latest/gel>`__.

.. _gel-dart-Client-queryRequiredSingle:

*method* ``.queryRequiredSingle()``
...................................


.. code-block:: dart

    Future queryRequiredSingle( 
      String query, [
      dynamic args]
    )

Executes a query, returning a single (non-``null``) result.

The query must return exactly one element. If the query returns more
than one element, a `ResultCardinalityMismatchError <https://pub.dev/documentation/gel/latest/gel/ResultCardinalityMismatchError-class.html>`__ error is thrown.
If the query returns an empty set, a `NoDataError <https://pub.dev/documentation/gel/latest/gel/NoDataError-class.html>`__ error is thrown.

For details on result types and ``args`` see the ``gel`` library
`docs page <https://pub.dev/documentation/gel/latest/gel>`__.

.. _gel-dart-Client-queryRequiredSingleJSON:

*method* ``.queryRequiredSingleJSON()``
.......................................


.. code-block:: dart

    Future<String> queryRequiredSingleJSON( 
      String query, [
      dynamic args]
    )

Executes a query, returning the result as a JSON encoded ``String``.

The query must return exactly one element. If the query returns more
than one element, a `ResultCardinalityMismatchError <https://pub.dev/documentation/gel/latest/gel/ResultCardinalityMismatchError-class.html>`__ error is thrown.
If the query returns an empty set, a `NoDataError <https://pub.dev/documentation/gel/latest/gel/NoDataError-class.html>`__ error is thrown.

For details on ``args`` see the ``gel`` library
`docs page <https://pub.dev/documentation/gel/latest/gel>`__.

.. _gel-dart-Client-querySQL:

*method* ``.querySQL()``
........................


.. code-block:: dart

    Future<List> querySQL( 
      String query, [
      dynamic args]
    )

Executes a SQL query, returning a ``List`` of results.

For details on result types and ``args`` see the ``gel`` library
`docs page <https://pub.dev/documentation/gel/latest/gel>`__.

.. _gel-dart-Client-querySingle:

*method* ``.querySingle()``
...........................


.. code-block:: dart

    Future querySingle( 
      String query, [
      dynamic args]
    )

Executes a query, returning a single (possibly ``null``) result.

The query must return no more than one element. If the query returns
more than one element, a `ResultCardinalityMismatchError <https://pub.dev/documentation/gel/latest/gel/ResultCardinalityMismatchError-class.html>`__ error is thrown.

For details on result types and ``args`` see the ``gel`` library
`docs page <https://pub.dev/documentation/gel/latest/gel>`__.

.. _gel-dart-Client-querySingleJSON:

*method* ``.querySingleJSON()``
...............................


.. code-block:: dart

    Future<String> querySingleJSON( 
      String query, [
      dynamic args]
    )

Executes a query, returning the result as a JSON encoded ``String``.

The query must return no more than one element. If the query returns
more than one element, a `ResultCardinalityMismatchError <https://pub.dev/documentation/gel/latest/gel/ResultCardinalityMismatchError-class.html>`__ error is thrown.

For details on ``args`` see the ``gel`` library
`docs page <https://pub.dev/documentation/gel/latest/gel>`__.

.. _gel-dart-Client-terminate:

*method* ``.terminate()``
.........................


.. code-block:: dart

    void terminate()

Immediately closes all connections in the client's pool, without waiting
for any running queries to finish.

.. _gel-dart-Client-transaction:

*method* ``.transaction<T>()``
..............................


.. code-block:: dart

    Future<T> transaction<T>( 
      Future<T> action( Transaction)
    )

Execute a retryable transaction.

Use this method to atomically execute multiple queries, where you also
need to run some logic client side. If you only need to run multiple
queries atomically, instead consider just using the ``execute()``/
``query*()`` methods - they all support queries containing multiple
statements.

The :ref:`transaction() <gel-dart-Client-transaction>` method expects an ``action`` function returning a
``Future``, and will automatically handle starting the transaction before
the ``action`` function is run, and commiting / rolling back the transaction
when the ``Future`` completes / throws an error.

The ``action`` function is passed a `Transaction <https://pub.dev/documentation/gel/latest/gel/Transaction-class.html>`__ object, which implements
the same ``execute()``/``query*()`` methods as on :ref:`Client <gel-dart-Client>`, and should be
used instead of the :ref:`Client <gel-dart-Client>` methods. The notable difference of these
methods on `Transaction <https://pub.dev/documentation/gel/latest/gel/Transaction-class.html>`__ as compared to the :ref:`Client <gel-dart-Client>` query methods, is
that they do not attempt to retry on errors. Instead the entire ``action``
function is re-executed if a retryable error (such as a transient
network error or transaction serialization error) is thrown inside it.
Non-retryable errors will cause the transaction to be automatically
rolled back, and the error re-thrown by :ref:`transaction() <gel-dart-Client-transaction>`.

A key implication of the whole ``action`` function being re-executed on
transaction retries, is that non-querying code will also be re-executed,
so the ``action`` should should not have side effects. It is also
recommended that the ``action`` does not have long running code, as
holding a transaction open is expensive on the server, and will negatively
impact performance.

The number of times :ref:`transaction() <gel-dart-Client-transaction>` will attempt to execute the
transaction, and the backoff timeout between retries can be configured
with :ref:`withRetryOptions() <gel-dart-Client-withRetryOptions>`.

.. _gel-dart-Client-withConfig:

*method* ``.withConfig()``
..........................


.. code-block:: dart

    Client withConfig( 
      Map<String, Object> config
    )

Returns a new :ref:`Client <gel-dart-Client>` instance with the specified client session
configuration.

The ``config`` parameter is merged with any existing
session config defined on the current client instance.

Equivalent to using the ``configure session`` command. For available
configuration parameters refer to the
`Config documentation </reference/stdlib/cfg#client-connections>`__.

.. _gel-dart-Client-withGlobals:

*method* ``.withGlobals()``
...........................


.. code-block:: dart

    Client withGlobals( 
      Map<String, dynamic> globals
    )

Returns a new :ref:`Client <gel-dart-Client>` instance with the specified global values.

The ``globals`` parameter is merged with any existing globals defined
on the current client instance.

Equivalent to using the ``set global`` command.

Example:

.. code-block:: dart

    final user = await client.withGlobals({
      'userId': '...'
    }).querySingle('''
      select User {name} filter .id = global userId
    ''');
    
.. _gel-dart-Client-withModuleAliases:

*method* ``.withModuleAliases()``
.................................


.. code-block:: dart

    Client withModuleAliases( 
      Map<String, String> aliases
    )

Returns a new :ref:`Client <gel-dart-Client>` instance with the specified module aliases.

The ``aliases`` parameter is merged with any existing module aliases
defined on the current client instance.

If the alias ``name`` is ``'module'`` this is equivalent to using the
``set module`` command, otherwise it is equivalent to the ``set alias``
command.

Example:

.. code-block:: dart

    final user = await client.withModuleAliases({
      'module': 'sys'
    }).querySingle('''
      select get_version_as_str()
    ''');
    // "2.0"
    
.. _gel-dart-Client-withRetryOptions:

*method* ``.withRetryOptions()``
................................


.. code-block:: dart

    Client withRetryOptions( 
      RetryOptions options
    )

Returns a new :ref:`Client <gel-dart-Client>` instance with the specified :ref:`RetryOptions <gel-dart-RetryOptions>`.

.. _gel-dart-Client-withSession:

*method* ``.withSession()``
...........................


.. code-block:: dart

    Client withSession( 
      Session session
    )

Returns a new :ref:`Client <gel-dart-Client>` instance with the specified :ref:`Session <gel-dart-Session>` options.

Instead of specifying an entirely new :ref:`Session <gel-dart-Session>` options object, :ref:`Client <gel-dart-Client>`
also implements the :ref:`withModuleAliases <gel-dart-Client-withModuleAliases>`, :ref:`withConfig <gel-dart-Client-withConfig>` and :ref:`withGlobals <gel-dart-Client-withGlobals>`
methods for convenience.

.. _gel-dart-Client-withTransactionOptions:

*method* ``.withTransactionOptions()``
......................................


.. code-block:: dart

    Client withTransactionOptions( 
      TransactionOptions options
    )

Returns a new :ref:`Client <gel-dart-Client>` instance with the specified :ref:`TransactionOptions <gel-dart-TransactionOptions>`.

.. _gel-dart-Options:

*class* Options
---------------

Manages all options (:ref:`RetryOptions <gel-dart-RetryOptions>`, :ref:`TransactionOptions <gel-dart-TransactionOptions>` and
:ref:`Session <gel-dart-Session>`) for a :ref:`Client <gel-dart-Client>`.

.. _gel-dart-Options-Options:

*constructor* ``Options()``
...........................


.. code-block:: dart

    Options({ 
      RetryOptions? retryOptions, 
      TransactionOptions? transactionOptions, 
      Session? session, }
    )


.. _gel-dart-Options-retryOptions:

*property* ``.retryOptions``
............................


.. code-block:: dart

    final RetryOptions retryOptions;


.. _gel-dart-Options-session:

*property* ``.session``
.......................


.. code-block:: dart

    final Session session;


.. _gel-dart-Options-transactionOptions:

*property* ``.transactionOptions``
..................................


.. code-block:: dart

    final TransactionOptions transactionOptions;


.. _gel-dart-Options-defaults:

*method* ``.defaults()``
........................


.. code-block:: dart

    Options defaults()

Creates a new :ref:`Options <gel-dart-Options>` object with all options set to their defaults.

.. _gel-dart-Options-withRetryOptions:

*method* ``.withRetryOptions()``
................................


.. code-block:: dart

    Options withRetryOptions( 
      RetryOptions options
    )

Returns a new :ref:`Options <gel-dart-Options>` object with the specified :ref:`RetryOptions <gel-dart-RetryOptions>`.

.. _gel-dart-Options-withSession:

*method* ``.withSession()``
...........................


.. code-block:: dart

    Options withSession( 
      Session session
    )

Returns a new :ref:`Options <gel-dart-Options>` object with the specified :ref:`Session <gel-dart-Session>` options.

.. _gel-dart-Options-withTransactionOptions:

*method* ``.withTransactionOptions()``
......................................


.. code-block:: dart

    Options withTransactionOptions( 
      TransactionOptions options
    )

Returns a new :ref:`Options <gel-dart-Options>` object with the specified :ref:`TransactionOptions <gel-dart-TransactionOptions>`.

.. _gel-dart-Session:

*class* Session
---------------

Configuration of a session, containing the config, aliases, and globals
to be used when executing a query.

.. _gel-dart-Session-Session:

*constructor* ``Session()``
...........................


.. code-block:: dart

    Session({ 
      String module = 'default', 
      Map<String, String>? moduleAliases, 
      Map<String, Object>? config, 
      Map<String, dynamic>? globals, }
    )

Creates a new :ref:`Session <gel-dart-Session>` object with the given options.

Refer to the individial ``with*`` methods for details on each option.

.. _gel-dart-Session-config:

*property* ``.config``
......................


.. code-block:: dart

    final Map<String, Object> config;


.. _gel-dart-Session-globals:

*property* ``.globals``
.......................


.. code-block:: dart

    final Map<String, dynamic> globals;


.. _gel-dart-Session-module:

*property* ``.module``
......................


.. code-block:: dart

    final String module;


.. _gel-dart-Session-moduleAliases:

*property* ``.moduleAliases``
.............................


.. code-block:: dart

    final Map<String, String> moduleAliases;


.. _gel-dart-Session-defaults:

*method* ``.defaults()``
........................


.. code-block:: dart

    Session defaults()

Creates a new :ref:`Session <gel-dart-Session>` with all options set to their defaults.

.. _gel-dart-Session-withConfig:

*method* ``.withConfig()``
..........................


.. code-block:: dart

    Session withConfig( 
      Map<String, Object> config
    )

Returns a new :ref:`Session <gel-dart-Session>` with the specified client session
configuration.

The ``config`` parameter is merged with any existing
session config defined on the current :ref:`Session <gel-dart-Session>`.

Equivalent to using the ``configure session`` command. For available
configuration parameters refer to the
`Config documentation </reference/stdlib/cfg#client-connections>`__.

.. _gel-dart-Session-withGlobals:

*method* ``.withGlobals()``
...........................


.. code-block:: dart

    Session withGlobals( 
      Map<String, dynamic> globals
    )

Returns a new :ref:`Session <gel-dart-Session>` with the specified global values.

The ``globals`` parameter is merged with any existing globals defined
on the current :ref:`Session <gel-dart-Session>`.

Equivalent to using the ``set global`` command.

.. _gel-dart-Session-withModuleAliases:

*method* ``.withModuleAliases()``
.................................


.. code-block:: dart

    Session withModuleAliases( 
      Map<String, String> aliases
    )

Returns a new :ref:`Session <gel-dart-Session>` with the specified module aliases.

The ``aliases`` parameter is merged with any existing module aliases
defined on the current :ref:`Session <gel-dart-Session>`.

If the alias ``name`` is ``'module'`` this is equivalent to using the
``set module`` command, otherwise it is equivalent to the ``set alias``
command.

.. _gel-dart-RetryOptions:

*class* RetryOptions
--------------------

Options that define how a :ref:`Client <gel-dart-Client>` will handle automatically retrying
queries in the event of a retryable error.

The options are specified by `RetryRule <https://pub.dev/documentation/gel/latest/gel/RetryRule-class.html>`__'s, which define a number of times
to attempt to retry a query, and a backoff function to determine how long
to wait after each retry before attempting the query again. :ref:`RetryOptions <gel-dart-RetryOptions>`
has a default `RetryRule <https://pub.dev/documentation/gel/latest/gel/RetryRule-class.html>`__, and can be configured with extra `RetryRule <https://pub.dev/documentation/gel/latest/gel/RetryRule-class.html>`__'s
which override the default for given error conditions.

.. _gel-dart-RetryOptions-RetryOptions:

*constructor* ``RetryOptions()``
................................


.. code-block:: dart

    RetryOptions({ 
      int? attempts, 
      BackoffFunction? backoff, }
    )

Creates a new :ref:`RetryOptions <gel-dart-RetryOptions>` object, with a default `RetryRule <https://pub.dev/documentation/gel/latest/gel/RetryRule-class.html>`__, with
the given ``attempts`` and ``backoff`` function.

If ``attempts`` or ``backoff`` are not specified, the defaults of 3 ``attempts``
and the exponential `defaultBackoff <https://pub.dev/documentation/gel/latest/gel/defaultBackoff.html>`__ function are used.

.. _gel-dart-RetryOptions-defaultRetryRule:

*property* ``.defaultRetryRule``
................................


.. code-block:: dart

    final RetryRule defaultRetryRule;


.. _gel-dart-RetryOptions-defaults:

*method* ``.defaults()``
........................


.. code-block:: dart

    RetryOptions defaults()

Creates a new :ref:`RetryOptions <gel-dart-RetryOptions>` with all options set to their defaults.

.. _gel-dart-RetryOptions-withRule:

*method* ``.withRule()``
........................


.. code-block:: dart

    RetryOptions withRule({ 
      required RetryCondition condition, 
      int? attempts, 
      BackoffFunction? backoff, }
    )

Adds a new `RetryRule <https://pub.dev/documentation/gel/latest/gel/RetryRule-class.html>`__ with the given ``attempts`` and ``backoff`` function,
that overrides the default `RetryRule <https://pub.dev/documentation/gel/latest/gel/RetryRule-class.html>`__ for a given error ``condition``.

If ``attempts`` or ``backoff`` are not specified, the values of the default
`RetryRule <https://pub.dev/documentation/gel/latest/gel/RetryRule-class.html>`__ of this :ref:`RetryOptions <gel-dart-RetryOptions>` are used.

.. _gel-dart-TransactionOptions:

*class* TransactionOptions
--------------------------

Defines the transaction mode that :ref:`Client.transaction <gel-dart-Client-transaction>` runs
transactions with.

For more details on transaction modes see the
`Transaction docs </reference/edgeql/transactions>`__.

.. _gel-dart-TransactionOptions-TransactionOptions:

*constructor* ``TransactionOptions()``
......................................


.. code-block:: dart

    TransactionOptions({ 
      IsolationLevel? isolation, 
      bool? readonly, 
      bool? deferrable, }
    )

Creates a new :ref:`TransactionOptions <gel-dart-TransactionOptions>` object with the given ``isolation``,
``readonly`` and ``deferrable`` options.

If not specified, the defaults are as follows:


* ``isolation``: serializable

* ``readonly``: false

* ``deferrable``: false

.. _gel-dart-TransactionOptions-deferrable:

*property* ``.deferrable``
..........................


.. code-block:: dart

    final bool deferrable;


.. _gel-dart-TransactionOptions-isolation:

*property* ``.isolation``
.........................


.. code-block:: dart

    final IsolationLevel isolation;


.. _gel-dart-TransactionOptions-readonly:

*property* ``.readonly``
........................


.. code-block:: dart

    final bool readonly;


.. _gel-dart-TransactionOptions-defaults:

*method* ``.defaults()``
........................


.. code-block:: dart

    TransactionOptions defaults()

Creates a new :ref:`TransactionOptions <gel-dart-TransactionOptions>` with all options set to their defaults.
