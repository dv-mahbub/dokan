class ApiEndpoints {
  static String baseUrl = 'https://apptest.dokandemo.com/wp-json';

  static String registration = '$baseUrl/wp/v2/users/register';
  static String login = '$baseUrl/jwt-auth/v1/token';
  static String getUserData = '$baseUrl/wp/v2/users/me';
}
