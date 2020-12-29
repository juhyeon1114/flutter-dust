import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_dust/models/Address.dart';
part 'User.g.dart';

@JsonSerializable(explicitToJson: true) // dart객체인 address를 json으로 보여주게 하기 위함
class User {
  final String name;
  final String email;
  @JsonKey(name: 'created_time') //json에서 키가 created_time으로 쓰이는 것을 dart객체에서는 createdTime으로 사용할 수 있게 해줌
  final int createdTime;
  final Address address;

  User(this.name, this.email, this.createdTime, this.address);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

/**
 * model을 정의하고 아래의 명령어를 실행하면, fromJson, toJson메서드가 auto generae됨
 * > flutter pub run build_runner build
 * > flutter pub run build_runner watch
 */