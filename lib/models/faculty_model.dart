class FacultyModel {
  String initial,name,email;

  FacultyModel(this.initial, this.name, this.email);

  FacultyModel.fromJson(Map<String,dynamic> json) {
    initial = json["initial"];
    name = json["name"];
    email = json["email"];
  }

}