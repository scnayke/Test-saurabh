import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class TestSaurabhFirebaseUser {
  TestSaurabhFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

TestSaurabhFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<TestSaurabhFirebaseUser> testSaurabhFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<TestSaurabhFirebaseUser>(
        (user) => currentUser = TestSaurabhFirebaseUser(user));
