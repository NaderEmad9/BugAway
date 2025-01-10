import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class NotificationService {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "chat-app-3654c",
      "private_key_id": "c24323c34dd63aac20bfa9b8bc43ba13af77e587",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCdwCureCJZZAhD\nmaDWNc12U7Kh50LXjtVMUIS0sYr6Dt65QBMCaCBOODjiWFn21CtvuYYROJGMCJ8N\nPBT2cSHqNBqXJzp6c9eZsHGoxcADIRjYNMvfsPxrfOesDDjpsfFh/aGj0DqhJjQI\nU2GQfGfnmvJAdgPjq2x8pL2V2R67w/gzF2RG6zYc6J4V8md2q+HSuZ8nQzF5AXe9\nfTE5NqliSjEFBg17KLpjSGrfNtEKAv3hzjpxyuC3FNU5+ZcXGPDwsHDCGq/wlBAm\nbfmzYUx8Sc34Uv0wR+P398VjvMGRfvL2qkBGsMkBSm3CDMHusdmRgbFxJ/j9EP9S\ns81aAW1fAgMBAAECggEAChWWVRRNcdR0uMmR4A+5bjaEhVgQzFHbrdC54wk0fq7D\nqyj+7hj087shW8rVGXPPwQklmmU43LBSZpiwKF7sEZo6Fu6RjPFp12/RnD3j++86\nNNwPKmIYiNCHyNZRLxNKgH6jviKaFOIp0lxuMLvbMpGTqe5BamTzfvZTDki+b7dK\nH+rnJIiGvZWD0P+LhKyQeU5gqQiSVr5LtHuTATP3Ba6BYNHCDW9UxpXtzTnN+i33\nrlPaaqmWK3sjDDuHuH/AgKZMmnfYuIII8vPsgM3Ibzz/FwP7w5pWiv7ACiABhHHN\nwtcrJJbX3UNuDOMKk+ZQOU7d/PiNLw1aqkgVmp9xlQKBgQDWWGk0NXwD4C0piscI\nRYbdOOKpHkWIZC6l0l3gLotkQi9hplTjXp4TzxliePsC+cnq2cTTkxf2ThUDzolF\nIiDUQQ6c1SDowem/7xXIJ2UB37ugJMNWXQoVw0A7HKxkksy7Iv50YmFD+BLKTUqf\nUgnUX05gN+XhQA9rVXm0xz33rQKBgQC8aDLAbtLAFgl+GxSb8pkzSw2+b1PrDj8Z\n+ZZR0bC5pNqdjKKB0O5chkURbvcUbUoZw/aofvJqBixsTHQkXuWJNv39Tt6DfJba\nnr3/VcSMiu5HAEFMO0RGEuhsEZgZgd6Ji9DTwjb9IbPYmSQO8I9yz7GDCMTRVr6Q\nIZmMmWvKuwKBgCmv5DYdONNgJChyLydyrjoUODEADDHsmg3yDgPtyXpkTObG/LeD\nzWa43o0CTn9TqWudkuQ7NWvX38pvvs7NRmlBheAGq3HZVObZTvkwgDqPEuSggcUo\nLy/wW2ujtfuReXPj6G0mPRiFBNKHmb3GrNa6+nlIJdNbLCSJ6TO5lFm5AoGAHIzB\nnA1vHDJ6r8RUxCjn9DDcXU4rbkQTZdE/aRiYahlEE3m7KmbJp/Wkw7aH9G13PB5I\n41GRVGWpF6QiOVyz9a4CoP7xkwUvKuPBMM8DYLSw1MuCGZYli2TUGYQ1AzB902P/\negdFI+iWgyz5nNXxNtmoMY4DnSFC8T5WMUsSXX8CgYANHae2E8/Zjpvvhs02qTo2\nuiKIh8dh+9rCFEnvAR7Zgdbr1CL5snvSynOERBVq/6wh4oyO6OMn7GoIdLNX9xwB\nHX+HBqoA1j8dYMMqSzUvwNYfUccDpl4iICKjjIFquvQKORPrCoiZSppvZn57u9Uu\n1nTAcJXFNTj1/TE5RYlDVA==\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-d8j7g@chat-app-3654c.iam.gserviceaccount.com",
      "client_id": "113863967484169664004",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-d8j7g%40chat-app-3654c.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };
    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];
    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);
    client.close();
    return credentials.accessToken.data;
  }

  static Future<void> sendNotification(
      String deviceToken, String title, String body) async {
    final String accessToken = await getAccessToken();
    String endpointFCM =
        'https://fcm.googleapis.com/v1/projects/chat-app-3654c/messages:send';
    final Map<String, dynamic> message = {
      "message": {
        "token": deviceToken,
        "notification": {"title": title, "body": body},
        "data": {
          "route": "serviceScreen",
        }
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointFCM),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(message),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification');
    }
  }
}
