import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/user_model.dart';
import '../../../services/auth_service.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class SendOtp extends AuthEvent {
  final String phoneNumber;
  const SendOtp(this.phoneNumber);
  @override
  List<Object?> get props => [phoneNumber];
}

class VerifyOtp extends AuthEvent {
  final String phoneNumber;
  final String otp;
  const VerifyOtp(this.phoneNumber, this.otp);
  @override
  List<Object?> get props => [phoneNumber, otp];
}

class CompleteProfile extends AuthEvent {
  final String displayName;
  final String? photoUrl;
  const CompleteProfile(this.displayName, this.photoUrl);
  @override
  List<Object?> get props => [displayName, photoUrl];
}

class Logout extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class OtpSent extends AuthState {
  final String phoneNumber;
  const OtpSent(this.phoneNumber);
  @override
  List<Object?> get props => [phoneNumber];
}

class AuthAuthenticated extends AuthState {
  final UserModel user;
  const AuthAuthenticated(this.user);
  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object?> get props => [message];
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<SendOtp>(_onSendOtp);
    on<VerifyOtp>(_onVerifyOtp);
    on<CompleteProfile>(_onCompleteProfile);
    on<Logout>(_onLogout);
  }

  Future<void> _onSendOtp(SendOtp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authService.sendOtp(event.phoneNumber);
      emit(OtpSent(event.phoneNumber));
    } catch (e) {
      emit(AuthError('فشل إرسال رمز التحقق: ${e.toString()}'));
    }
  }

  Future<void> _onVerifyOtp(VerifyOtp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authService.verifyOtp(event.phoneNumber, event.otp);
      if (user.displayName == null) {
        emit(OtpSent(event.phoneNumber)); // Need profile setup
      } else {
        emit(AuthAuthenticated(user));
      }
    } catch (e) {
      emit(AuthError('رمز التحقق غير صحيح'));
    }
  }

  Future<void> _onCompleteProfile(CompleteProfile event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authService.completeProfile(event.displayName, event.photoUrl);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError('فشل إكمال الملف الشخصي'));
    }
  }

  Future<void> _onLogout(Logout event, Emitter<AuthState> emit) async {
    await _authService.logout();
    emit(AuthUnauthenticated());
  }
}
