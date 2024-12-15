// profile_state.dart
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String name;
  final String email;
  final String phone;
  final String photoUrl;
  final bool isRefreshing; // Indicates if fresh data is being loaded

  ProfileLoaded({
    required this.name,
    required this.email,
    required this.phone,
    required this.photoUrl,
    this.isRefreshing = false,
  });
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}
