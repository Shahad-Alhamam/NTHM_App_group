import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProfileCubit() : super(ProfileInitial());

  Future<void> loadUserProfile(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final cachedName = prefs.getString('user_name_$userId') ?? '';
      final cachedEmail = prefs.getString('user_email_$userId') ?? '';
      final cachedPhone = prefs.getString('user_phone_$userId') ?? '';
      final cachedPhotoUrl = prefs.getString('user_photo_$userId') ?? '';

      if (cachedName.isNotEmpty && cachedEmail.isNotEmpty) {
        emit(ProfileLoaded(
          name: cachedName,
          email: cachedEmail,
          phone: cachedPhone,
          photoUrl: cachedPhotoUrl,
          isRefreshing: true,
        ));
      } else {
        emit(ProfileLoading());
      }

      DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(userId).get();
      if (userSnapshot.exists) {
        final data = userSnapshot.data() as Map<String, dynamic>;

        final name = data['name'] ?? '';
        final email = data['email'] ?? '';
        final phone = data['phone'] ?? '';
        final photoUrl = data['photo'] ?? '';

        if (name.isEmpty || email.isEmpty) {
          throw Exception('Incomplete user data.');
        }

        await prefs.setString('user_name_$userId', name);
        await prefs.setString('user_email_$userId', email);
        await prefs.setString('user_phone_$userId', phone);
        await prefs.setString('user_photo_$userId', photoUrl);

        emit(ProfileLoaded(
          name: name,
          email: email,
          phone: phone,
          photoUrl: photoUrl,
          isRefreshing: false,
        ));
      } else {
        if (cachedName.isEmpty) {
          emit(ProfileError('User not found.'));
        }
      }
    } on FirebaseException catch (e) {
      emit(ProfileError('Firebase error: ${e.message}'));
    } on Exception catch (e) {
      emit(ProfileError('Error: ${e.toString()}'));
    }
  }
}
