abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {}

class Notificationfailer extends NotificationState {
  final String failer;
  Notificationfailer(this.failer);
}
