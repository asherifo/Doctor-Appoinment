
class DoctorResponse {
  final String message;
  final List<DoctorModel> data;

  DoctorResponse({
    required this.message,
    required this.data,
  });

  factory DoctorResponse.fromJson(Map<String, dynamic> json) {
    return DoctorResponse(
      message: json['message'] ?? '',
      data: (json['data'] as List?)
          ?.map((e) => DoctorModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}

class DoctorModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String photo;
  final String gender;
  final String address;
  final String description;
  final String degree;
  final Specialization specialization;
  final City city;
  final int appointPrice;
  final String startTime;
  final String endTime;

  DoctorModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.gender,
    required this.address,
    required this.description,
    required this.degree,
    required this.specialization,
    required this.city,
    required this.appointPrice,
    required this.startTime,
    required this.endTime,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      photo: json['photo'] ?? '',
      gender: json['gender'] ?? '',
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      degree: json['degree'] ?? '',
      specialization: Specialization.fromJson(json['specialization'] ?? {}),
      city: City.fromJson(json['city'] ?? {}),
      appointPrice: json['appoint_price'] ?? 0,
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
    );
  }
}

class Specialization {
  final int id;
  final String name;

  Specialization({required this.id, required this.name});

  factory Specialization.fromJson(Map<String, dynamic> json) {
    return Specialization(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class City {
  final int id;
  final String name;
  final Governrate governrate;

  City({
    required this.id,
    required this.name,
    required this.governrate,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      governrate: Governrate.fromJson(json['governrate'] ?? {}),
    );
  }
}

class Governrate {
  final int id;
  final String name;

  Governrate({required this.id, required this.name});

  factory Governrate.fromJson(Map<String, dynamic> json) {
    return Governrate(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}