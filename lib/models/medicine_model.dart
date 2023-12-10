  class Medicine {
    final List<dynamic>? notificationIDs;
    final String? MedicineName;
    final int? dose;
    final String? starttime;
    final String? medicineType;
    final int? interval;

    Medicine({this.notificationIDs, this.MedicineName, this.dose, this.starttime,
        this.medicineType, this.interval});

    Map<String, dynamic> toJson() {
      return {
        'ids': notificationIDs,
        'name': MedicineName,
        'dosage': dose,
        'start': starttime,
        'type': medicineType,
        'interval': interval,
      };
    }

    factory Medicine.fromJson(Map<String, dynamic> parsedJson) {
      return Medicine(
        notificationIDs: parsedJson['ids'],
        MedicineName: parsedJson['name'],
        dose: parsedJson['dosage'],
        starttime: parsedJson['start'],
        medicineType: parsedJson['type'],
        interval: parsedJson['interval'],
      );
    }
  }
