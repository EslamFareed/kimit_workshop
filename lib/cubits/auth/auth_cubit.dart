import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kimit_workshop/db/shared_prefs/prefs_helper.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  final auth = FirebaseAuth.instance;
  User? currentUser;

  final db = FirebaseFirestore.instance;
  Map<String, dynamic> userData = {};

  Future<void> logout() async {
    await PrefsHelper.prefs.remove("isLogin");
    await PrefsHelper.prefs.remove("id");
  }

  void getData() {
    emit(LoadingProfile());
    String id = PrefsHelper.prefs.getString("id") ?? "";
    db.collection("Users").doc(id).get().then((value) {
      if (value.exists) {
        userData = value.data()!;
        emit(SuccessProfile());
      } else {
        emit(ErrorProfile());
      }
    }).catchError((error) {
      print(error.toString());
      emit(ErrorProfile());
    });
  }

  bool checkLogin() {
    bool? isLogin = PrefsHelper.prefs.containsKey("isLogin");
    print(isLogin);
    if (isLogin == null) {
      return false;
    } else {
      return isLogin;
    }
  }

  void login(String email, String password) {
    emit(LoadingLogin());
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      if (value.user != null) {
        currentUser = value.user;

        await PrefsHelper.prefs.setBool("isLogin", true);
        await PrefsHelper.prefs.setString("id", currentUser!.uid);

        emit(SuccessLogin());
      } else {
        emit(ErrorLogin());
      }
    }).catchError((error) {
      emit(ErrorLogin());
      print(error.toString());
    });
  }

  void createAccount(String email, String password, String phone, String name) {
    emit(LoadingCreateAccount());

    try {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (value.user != null) {
          currentUser = value.user;
          await saveDataToFireStore(phone, name, email);
        } else {
          emit(ErrorCreateAccount());
        }
      });
    } catch (e) {
      print(e.toString());
      emit(ErrorCreateAccount());
    }
  }

  Future<void> saveDataToFireStore(
      String phone, String name, String email) async {
    await db.collection("Users").doc(currentUser!.uid).set({
      "name": name,
      "phone": phone,
      "email": email,
    }).then((value) {
      emit(SuccessCreateAccount());
    });
  }
}
