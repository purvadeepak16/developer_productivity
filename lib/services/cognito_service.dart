import 'package:amazon_cognito_identity_dart_2/cognito.dart';

class CognitoService {

  // 🔹 Replace with your real values
  final CognitoUserPool userPool = CognitoUserPool(
    'eu-north-1_Z4cAx5fbA',   // example: eu-north-1_xxxxx
    '4hdroivch127hg4pakf9edi4df',      // example: 4abcd123xyz
  );

  // ===============================
  // 🔹 SIGN UP
  // ===============================
  Future<String> signUp(String email, String password) async {
    try {
      await userPool.signUp(email, password);
      return "Sign up successful. Check your email.";
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }

  // ===============================
  // 🔹 CONFIRM SIGN UP (OTP)
  // ===============================
  Future<String> confirmSignUp(String email, String code) async {
    try {
      final cognitoUser = CognitoUser(email, userPool);

      await cognitoUser.confirmRegistration(code);

      return "Account confirmed successfully";
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }

  // ===============================
  // 🔹 RESEND OTP (Optional)
  // ===============================
  Future<String> resendConfirmationCode(String email) async {
    try {
      final cognitoUser = CognitoUser(email, userPool);

      await cognitoUser.resendConfirmationCode();

      return "Verification code resent. Check your email.";
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }

  // ===============================
  // 🔹 SIGN IN
  // ===============================
  Future<String> signIn(String email, String password) async {
    try {
      final cognitoUser = CognitoUser(email, userPool);

      final authDetails = AuthenticationDetails(
        username: email,
        password: password,
      );

      await cognitoUser.authenticateUser(authDetails);

      return "Login successful";
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }
}