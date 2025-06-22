class Skill {
  final String name;
  final int proficiency; // 0-100

  Skill({required this.name, required this.proficiency});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(name: json['name'], proficiency: json['proficiency']);
  }
}
