import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();
  Future<Map<String, dynamic>> loadAgents() {
    return BaseNetwork.get("agents");
  }

  Future<Map<String, dynamic>> loadMaps() {
    return BaseNetwork.get("maps");
  }

  Future<Map<String, dynamic>> loadAgentDetails(String uId) {
    String id = uId.toString();
    return BaseNetwork.get("agents/$id");
  }

  // Future<Map<String, dynamic>> loadMealDetails(String idMeal) {
  //   String id = idMeal.toString();
  //   return BaseNetwork.get("lookup.php?i=$id");
  // }
}
