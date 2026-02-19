import 'package:lara_chatbot/core/interfaces/domain/entity.dart';

abstract class Model extends Entity {
  Map<String, dynamic> toJson();
}
