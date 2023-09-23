class PersonDetail {
  int? id;
  String? name;
  String? gender;
  String? address;
  String? dob;
  String? emailAddress;
  String? mobileNumber;
  String? state;
  String? district;

  PersonDetail(
      {this.id,
      this.name,
      this.gender,
      this.address,
      this.dob,
      this.emailAddress,
      this.mobileNumber,
      this.state,
      this.district});

  Map<String, dynamic> mapPersonDetail() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'address': address,
      'dob': dob,
      'emailAddress': emailAddress,
      'mobileNumber': mobileNumber,
      'state': state,
      'district': district,
    };
  }
}
