// AUTOGENERATED
// ignore_for_file: overridden_fields

import 'base.dart';

export 'base.dart' show GelError, GelErrorTag;

class InternalServerError extends GelError {
  InternalServerError(super.message, [super.source]);

  final code = 0x01000000;
}

class UnsupportedFeatureError extends GelError {
  UnsupportedFeatureError(super.message, [super.source]);

  final code = 0x02000000;
}

class ProtocolError extends GelError {
  ProtocolError(super.message, [super.source]);

  final code = 0x03000000;
}

class BinaryProtocolError extends ProtocolError {
  BinaryProtocolError(super.message, [super.source]);

  @override
  final code = 0x03010000;
}

class UnsupportedProtocolVersionError extends BinaryProtocolError {
  UnsupportedProtocolVersionError(super.message, [super.source]);

  @override
  final code = 0x03010001;
}

class TypeSpecNotFoundError extends BinaryProtocolError {
  TypeSpecNotFoundError(super.message, [super.source]);

  @override
  final code = 0x03010002;
}

class UnexpectedMessageError extends BinaryProtocolError {
  UnexpectedMessageError(super.message, [super.source]);

  @override
  final code = 0x03010003;
}

class InputDataError extends ProtocolError {
  InputDataError(super.message, [super.source]);

  @override
  final code = 0x03020000;
}

class ParameterTypeMismatchError extends InputDataError {
  ParameterTypeMismatchError(super.message, [super.source]);

  @override
  final code = 0x03020100;
}

class StateMismatchError extends InputDataError {
  StateMismatchError(super.message, [super.source]);

  @override
  final code = 0x03020200;

  @override
  final tags = {GelErrorTag.shouldRetry};
}

class ResultCardinalityMismatchError extends ProtocolError {
  ResultCardinalityMismatchError(super.message, [super.source]);

  @override
  final code = 0x03030000;
}

class CapabilityError extends ProtocolError {
  CapabilityError(super.message, [super.source]);

  @override
  final code = 0x03040000;
}

class UnsupportedCapabilityError extends CapabilityError {
  UnsupportedCapabilityError(super.message, [super.source]);

  @override
  final code = 0x03040100;
}

class DisabledCapabilityError extends CapabilityError {
  DisabledCapabilityError(super.message, [super.source]);

  @override
  final code = 0x03040200;
}

class QueryError extends GelError {
  QueryError(super.message, [super.source]);

  final code = 0x04000000;
}

class InvalidSyntaxError extends QueryError {
  InvalidSyntaxError(super.message, [super.source]);

  @override
  final code = 0x04010000;
}

class EdgeQLSyntaxError extends InvalidSyntaxError {
  EdgeQLSyntaxError(super.message, [super.source]);

  @override
  final code = 0x04010100;
}

class SchemaSyntaxError extends InvalidSyntaxError {
  SchemaSyntaxError(super.message, [super.source]);

  @override
  final code = 0x04010200;
}

class GraphQLSyntaxError extends InvalidSyntaxError {
  GraphQLSyntaxError(super.message, [super.source]);

  @override
  final code = 0x04010300;
}

class InvalidTypeError extends QueryError {
  InvalidTypeError(super.message, [super.source]);

  @override
  final code = 0x04020000;
}

class InvalidTargetError extends InvalidTypeError {
  InvalidTargetError(super.message, [super.source]);

  @override
  final code = 0x04020100;
}

class InvalidLinkTargetError extends InvalidTargetError {
  InvalidLinkTargetError(super.message, [super.source]);

  @override
  final code = 0x04020101;
}

class InvalidPropertyTargetError extends InvalidTargetError {
  InvalidPropertyTargetError(super.message, [super.source]);

  @override
  final code = 0x04020102;
}

class InvalidReferenceError extends QueryError {
  InvalidReferenceError(super.message, [super.source]);

  @override
  final code = 0x04030000;
}

class UnknownModuleError extends InvalidReferenceError {
  UnknownModuleError(super.message, [super.source]);

  @override
  final code = 0x04030001;
}

class UnknownLinkError extends InvalidReferenceError {
  UnknownLinkError(super.message, [super.source]);

  @override
  final code = 0x04030002;
}

class UnknownPropertyError extends InvalidReferenceError {
  UnknownPropertyError(super.message, [super.source]);

  @override
  final code = 0x04030003;
}

class UnknownUserError extends InvalidReferenceError {
  UnknownUserError(super.message, [super.source]);

  @override
  final code = 0x04030004;
}

class UnknownDatabaseError extends InvalidReferenceError {
  UnknownDatabaseError(super.message, [super.source]);

  @override
  final code = 0x04030005;
}

class UnknownParameterError extends InvalidReferenceError {
  UnknownParameterError(super.message, [super.source]);

  @override
  final code = 0x04030006;
}

class DeprecatedScopingError extends InvalidReferenceError {
  DeprecatedScopingError(super.message, [super.source]);

  @override
  final code = 0x04030007;
}

class SchemaError extends QueryError {
  SchemaError(super.message, [super.source]);

  @override
  final code = 0x04040000;
}

class SchemaDefinitionError extends QueryError {
  SchemaDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050000;
}

class InvalidDefinitionError extends SchemaDefinitionError {
  InvalidDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050100;
}

class InvalidModuleDefinitionError extends InvalidDefinitionError {
  InvalidModuleDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050101;
}

class InvalidLinkDefinitionError extends InvalidDefinitionError {
  InvalidLinkDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050102;
}

class InvalidPropertyDefinitionError extends InvalidDefinitionError {
  InvalidPropertyDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050103;
}

class InvalidUserDefinitionError extends InvalidDefinitionError {
  InvalidUserDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050104;
}

class InvalidDatabaseDefinitionError extends InvalidDefinitionError {
  InvalidDatabaseDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050105;
}

class InvalidOperatorDefinitionError extends InvalidDefinitionError {
  InvalidOperatorDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050106;
}

class InvalidAliasDefinitionError extends InvalidDefinitionError {
  InvalidAliasDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050107;
}

class InvalidFunctionDefinitionError extends InvalidDefinitionError {
  InvalidFunctionDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050108;
}

class InvalidConstraintDefinitionError extends InvalidDefinitionError {
  InvalidConstraintDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050109;
}

class InvalidCastDefinitionError extends InvalidDefinitionError {
  InvalidCastDefinitionError(super.message, [super.source]);

  @override
  final code = 0x0405010a;
}

class DuplicateDefinitionError extends SchemaDefinitionError {
  DuplicateDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050200;
}

class DuplicateModuleDefinitionError extends DuplicateDefinitionError {
  DuplicateModuleDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050201;
}

class DuplicateLinkDefinitionError extends DuplicateDefinitionError {
  DuplicateLinkDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050202;
}

class DuplicatePropertyDefinitionError extends DuplicateDefinitionError {
  DuplicatePropertyDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050203;
}

class DuplicateUserDefinitionError extends DuplicateDefinitionError {
  DuplicateUserDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050204;
}

class DuplicateDatabaseDefinitionError extends DuplicateDefinitionError {
  DuplicateDatabaseDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050205;
}

class DuplicateOperatorDefinitionError extends DuplicateDefinitionError {
  DuplicateOperatorDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050206;
}

class DuplicateViewDefinitionError extends DuplicateDefinitionError {
  DuplicateViewDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050207;
}

class DuplicateFunctionDefinitionError extends DuplicateDefinitionError {
  DuplicateFunctionDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050208;
}

class DuplicateConstraintDefinitionError extends DuplicateDefinitionError {
  DuplicateConstraintDefinitionError(super.message, [super.source]);

  @override
  final code = 0x04050209;
}

class DuplicateCastDefinitionError extends DuplicateDefinitionError {
  DuplicateCastDefinitionError(super.message, [super.source]);

  @override
  final code = 0x0405020a;
}

class DuplicateMigrationError extends DuplicateDefinitionError {
  DuplicateMigrationError(super.message, [super.source]);

  @override
  final code = 0x0405020b;
}

class SessionTimeoutError extends QueryError {
  SessionTimeoutError(super.message, [super.source]);

  @override
  final code = 0x04060000;
}

class IdleSessionTimeoutError extends SessionTimeoutError {
  IdleSessionTimeoutError(super.message, [super.source]);

  @override
  final code = 0x04060100;

  @override
  final tags = {GelErrorTag.shouldRetry};
}

class QueryTimeoutError extends SessionTimeoutError {
  QueryTimeoutError(super.message, [super.source]);

  @override
  final code = 0x04060200;
}

class TransactionTimeoutError extends SessionTimeoutError {
  TransactionTimeoutError(super.message, [super.source]);

  @override
  final code = 0x04060a00;
}

class IdleTransactionTimeoutError extends TransactionTimeoutError {
  IdleTransactionTimeoutError(super.message, [super.source]);

  @override
  final code = 0x04060a01;
}

class ExecutionError extends GelError {
  ExecutionError(super.message, [super.source]);

  final code = 0x05000000;
}

class InvalidValueError extends ExecutionError {
  InvalidValueError(super.message, [super.source]);

  @override
  final code = 0x05010000;
}

class DivisionByZeroError extends InvalidValueError {
  DivisionByZeroError(super.message, [super.source]);

  @override
  final code = 0x05010001;
}

class NumericOutOfRangeError extends InvalidValueError {
  NumericOutOfRangeError(super.message, [super.source]);

  @override
  final code = 0x05010002;
}

class AccessPolicyError extends InvalidValueError {
  AccessPolicyError(super.message, [super.source]);

  @override
  final code = 0x05010003;
}

class QueryAssertionError extends InvalidValueError {
  QueryAssertionError(super.message, [super.source]);

  @override
  final code = 0x05010004;
}

class IntegrityError extends ExecutionError {
  IntegrityError(super.message, [super.source]);

  @override
  final code = 0x05020000;
}

class ConstraintViolationError extends IntegrityError {
  ConstraintViolationError(super.message, [super.source]);

  @override
  final code = 0x05020001;
}

class CardinalityViolationError extends IntegrityError {
  CardinalityViolationError(super.message, [super.source]);

  @override
  final code = 0x05020002;
}

class MissingRequiredError extends IntegrityError {
  MissingRequiredError(super.message, [super.source]);

  @override
  final code = 0x05020003;
}

class TransactionError extends ExecutionError {
  TransactionError(super.message, [super.source]);

  @override
  final code = 0x05030000;
}

class TransactionConflictError extends TransactionError {
  TransactionConflictError(super.message, [super.source]);

  @override
  final code = 0x05030100;

  @override
  final tags = {GelErrorTag.shouldRetry};
}

class TransactionSerializationError extends TransactionConflictError {
  TransactionSerializationError(super.message, [super.source]);

  @override
  final code = 0x05030101;

  @override
  final tags = {GelErrorTag.shouldRetry};
}

class TransactionDeadlockError extends TransactionConflictError {
  TransactionDeadlockError(super.message, [super.source]);

  @override
  final code = 0x05030102;

  @override
  final tags = {GelErrorTag.shouldRetry};
}

class WatchError extends ExecutionError {
  WatchError(super.message, [super.source]);

  @override
  final code = 0x05040000;
}

class ConfigurationError extends GelError {
  ConfigurationError(super.message, [super.source]);

  final code = 0x06000000;
}

class AccessError extends GelError {
  AccessError(super.message, [super.source]);

  final code = 0x07000000;
}

class AuthenticationError extends AccessError {
  AuthenticationError(super.message, [super.source]);

  @override
  final code = 0x07010000;
}

class AvailabilityError extends GelError {
  AvailabilityError(super.message, [super.source]);

  final code = 0x08000000;
}

class BackendUnavailableError extends AvailabilityError {
  BackendUnavailableError(super.message, [super.source]);

  @override
  final code = 0x08000001;

  @override
  final tags = {GelErrorTag.shouldRetry};
}

class ServerOfflineError extends AvailabilityError {
  ServerOfflineError(super.message, [super.source]);

  @override
  final code = 0x08000002;

  @override
  final tags = {GelErrorTag.shouldReconnect, GelErrorTag.shouldRetry};
}

class UnknownTenantError extends AvailabilityError {
  UnknownTenantError(super.message, [super.source]);

  @override
  final code = 0x08000003;

  @override
  final tags = {GelErrorTag.shouldReconnect, GelErrorTag.shouldRetry};
}

class ServerBlockedError extends AvailabilityError {
  ServerBlockedError(super.message, [super.source]);

  @override
  final code = 0x08000004;
}

class BackendError extends GelError {
  BackendError(super.message, [super.source]);

  final code = 0x09000000;
}

class UnsupportedBackendFeatureError extends BackendError {
  UnsupportedBackendFeatureError(super.message, [super.source]);

  @override
  final code = 0x09000100;
}

class LogMessage extends GelError {
  LogMessage(super.message, [super.source]);

  final code = 0xf0000000;
}

class WarningMessage extends LogMessage {
  WarningMessage(super.message, [super.source]);

  @override
  final code = 0xf0010000;
}

class ClientError extends GelError {
  ClientError(super.message, [super.source]);

  final code = 0xff000000;
}

class ClientConnectionError extends ClientError {
  ClientConnectionError(super.message, [super.source]);

  @override
  final code = 0xff010000;
}

class ClientConnectionFailedError extends ClientConnectionError {
  ClientConnectionFailedError(super.message, [super.source]);

  @override
  final code = 0xff010100;
}

class ClientConnectionFailedTemporarilyError
    extends ClientConnectionFailedError {
  ClientConnectionFailedTemporarilyError(super.message, [super.source]);

  @override
  final code = 0xff010101;

  @override
  final tags = {GelErrorTag.shouldReconnect, GelErrorTag.shouldRetry};
}

class ClientConnectionTimeoutError extends ClientConnectionError {
  ClientConnectionTimeoutError(super.message, [super.source]);

  @override
  final code = 0xff010200;

  @override
  final tags = {GelErrorTag.shouldReconnect, GelErrorTag.shouldRetry};
}

class ClientConnectionClosedError extends ClientConnectionError {
  ClientConnectionClosedError(super.message, [super.source]);

  @override
  final code = 0xff010300;

  @override
  final tags = {GelErrorTag.shouldReconnect, GelErrorTag.shouldRetry};
}

class InterfaceError extends ClientError {
  InterfaceError(super.message, [super.source]);

  @override
  final code = 0xff020000;
}

class QueryArgumentError extends InterfaceError {
  QueryArgumentError(super.message, [super.source]);

  @override
  final code = 0xff020100;
}

class MissingArgumentError extends QueryArgumentError {
  MissingArgumentError(super.message, [super.source]);

  @override
  final code = 0xff020101;
}

class UnknownArgumentError extends QueryArgumentError {
  UnknownArgumentError(super.message, [super.source]);

  @override
  final code = 0xff020102;
}

class InvalidArgumentError extends QueryArgumentError {
  InvalidArgumentError(super.message, [super.source]);

  @override
  final code = 0xff020103;
}

class NoDataError extends ClientError {
  NoDataError(super.message, [super.source]);

  @override
  final code = 0xff030000;
}

class InternalClientError extends ClientError {
  InternalClientError(super.message, [super.source]);

  @override
  final code = 0xff040000;
}
