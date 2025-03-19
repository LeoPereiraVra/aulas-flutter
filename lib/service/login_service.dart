import 'package:app_provider/model/auth_response.dart';
import 'package:app_provider/service/api_service.dart';
import 'package:app_provider/util/result.dart';

class LoginApiClient extends ApiService{

  Future<Result<AuthResponse>> login(String login, String password) async {
    
    try {

      var result = await post('api/v1/login',params: {'login' : login, 'password' : password });
            
      switch (result) {
        
        case Ok<Map<String, dynamic>>():
                 
          return Result.ok(AuthResponse.fromJson(result.value));
        case Error<Map<String, dynamic>>():
          
          return Result.error(result.error);
      }      
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}