import '../constants/supabaseClient.dart';

class AuthService {
  insertNewProfileData() async {
    var userId = client.auth.currentUser;
    var user = userId?.id;

    await client.from('profile').insert({
      'id': user,
    });
  }

  Future<String?> signupUser({email, password}) async {
    String myreturn = '';

    try {
      await client.auth.signUp(password: password, email: email).then(
        (value) {
          insertNewProfileData();
        },
      );
      // return '';
    } catch (e) {
      if (e.toString() == 'AuthException(message: Email rate limit exceeded, statusCode: 429)') {
        myreturn = 'Server Busy. Please try again after 30min';
      }
      myreturn = e.toString();
    }
    return myreturn;
  }
}
