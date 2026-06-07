class User{
  final String name;
  final String email;
  User(this.name, this.email);

  factory User.fromJson(Map<String, dynamic> json){
    return User(json['name'], json['email']);
  }

  @override
  String toString() {
    return 'User{name: $name, email: $email}';
  }
}

class UserRepository{
    Future<List<User>> getAll() async{
      await Future.delayed(Duration(seconds: 2));
      final List<Map<String, dynamic>> jsonData = [
        {'name': 'Alice', 'email': 'alice@example.com'},
        {'name': 'Bob', 'email': 'bob@example.com'},
        {'name': 'Charlie', 'email': 'charlie@example.com'},
      ];
      return jsonData.map(User.fromJson).toList();
    }
  }

  void main(){
    final userRepository = UserRepository();
    
    userRepository.getAll().then((users) {
      print('Users: $users');
    });
  }