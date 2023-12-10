import 'dart:convert';

import 'package:app12_finalprojct/cubit/cubit_states.dart';
import 'package:app12_finalprojct/notification/notification.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/medicine_model.dart';

class NotificationCubit extends Cubit<NotificationState> {
  static const String _key = 'medicine_list';
  NotificationCubit() : super(NotificationInitial());
  //List<Medicine> MedicinesList = [];
  String ?selectedtime;

  Future<void> saveMedicines(medicines) async {
    try {
      emit(NotificationLoading());
      final prefs = await SharedPreferences.getInstance();
      List<Medicine> existingMedicines = await getMedicines();
      // MedicinesList = existingMedicines;
      // Add the new medicine to the existing list
      existingMedicines.add(medicines);

      // Convert the list to JSON and save it
      final List<String> medicineJsonList = existingMedicines
          .map((medicine) => json.encode(medicine.toJson()))
          .toList();
      await prefs.setStringList(_key, medicineJsonList);

      emit(NotificationSuccess());
      print('success');
      print(existingMedicines);
    } catch (e) {
      print('Error while saving the list of medicines $e');
      emit(Notificationfailer(e.toString()));
      getMedicines();
    }
  }

  Future<List<Medicine>> getMedicines() async {
    try {

      final prefs = await SharedPreferences.getInstance();
      final List<String>? medicineJsonList = prefs.getStringList(_key);
      if (medicineJsonList == null) {
        return [];
      } else {
        print('data getMedicines');
        return medicineJsonList
            .map((medicineJson) => Medicine.fromJson(json.decode(medicineJson)))
            .toList();
            
      }
    } catch (e) {
      print('Error while saving the list of medicines $e');
      return [];
    }
  }

  Future<void> deleteMedicine(Medicine medicine) async {
  var medicineName = medicine.MedicineName;
    try {
      List<Medicine> existingMedicines = await getMedicines();

      // Find the index of the medicine to be deleted
      int indexToDelete = existingMedicines.indexWhere(
          (medicine) => medicine.MedicineName == medicineName);

      if (indexToDelete != -1) {
        // Remove the medicine from the list
        existingMedicines.removeAt(indexToDelete);

        // Convert the updated list to JSON and save it
        final List<String> medicineJsonList = existingMedicines
            .map((medicine) => json.encode(medicine.toJson()))
            .toList();

        final prefs = await SharedPreferences.getInstance();
        await prefs.setStringList(_key, medicineJsonList);

        print('Successfully deleted medicine: $medicineName');
        print(existingMedicines);
      } else {
        print('Medicine not found: $medicineName');
        emit(Notificationfailer('Medicine not found'));
      }
    } catch (e) {
      print('Error while deleting the medicine $medicineName: $e');
    }

     for (int i = 0; i < (24 / medicine.interval!).floor(); i++) {
         NotificationServicesHelper.instance.cancelNotification(int.parse(medicine.notificationIDs![i]));

    }
  }
}
