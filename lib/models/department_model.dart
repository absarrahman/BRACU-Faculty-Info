class DepartmentModel {
  String name,link;

  DepartmentModel(this.name, this.link);

  DepartmentModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    link = json["link"];
  }
}