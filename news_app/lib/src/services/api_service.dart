import 'package:http/http.dart' as http;
import 'package:news_app/src/models/news_model.dart';
import 'package:news_app/src/services/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApiService{
// Future<List<NewsElement>?> getNewsData()async{
//   var url=Uri.parse(ApiConstants.baseUrl+ApiConstants.endPoint);
//   try{
//     var response=await http.get(url);
//     if(response.statusCode==200){
//       final fromJson= (response.body);
//       return fromJson.news;
//     }
//   }catch(e){
//     print(e.toString());
//   }
// }


static const String cacheKey='cachedNewsData';

Future<List<NewsElement>?> getNewsData()async{
  var url = Uri.parse(ApiConstants.baseUrl+ApiConstants.endPoint);
  try{
    var respone=await http.get(url);
    if(respone.statusCode==200){
      final fromJson=newsFromJson(respone.body);
      await _cachedNewsData(respone.body);
      return fromJson.news;
    }
  }catch (e){
    print(e.toString());
    return await getCachedNewsData();
  }
  return null;

}
Future<void> _cachedNewsData(String jsonData)async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  await prefs.setString(cacheKey, jsonData);
}

Future<List<NewsElement>?>getCachedNewsData()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  String? jsonData=prefs.getString(cacheKey);
  if(jsonData!= null){
    final fromJson=newsFromJson(jsonData);
    return fromJson.news;
  }
  return null;
}

}