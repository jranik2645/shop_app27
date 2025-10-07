import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "shopapp27-8bfd7",
        "private_key_id": "0c560a253234b1274c4206ce4bb67c4283462778",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDRqGtyMG0Lt0pW\n0lYqXW5fk7PgFnibEGa8U5xghlfPSF1BgqF+oawLOnoufK7etA6y+tfiNte+cGir\nRLVAtR6pRD0T0w5GzqDrCLUAlFWS0r2PqB3HhlP6pQyT4NOJ5BNmdb16+paB6tXC\nX7v2sxbvd26Bsy7Au4/gp/2DkRa5rdoM6s5nrd4jdCr3OYp4uZ3bJK03Fw8wxBBV\n0hx20GrYwDlm1gBj9ugTNXHOlwS6CZ3bkj0e9tvdGE+HpNnpYaW/CS1a9g4GwtlD\n6mIqYZOcyBcDHRpmUDjX/D/qPkHjU68dv3SY+JnY156BMJouTG+bmBcJ9oNb7evI\nP+Ei1cqbAgMBAAECggEALmi0mAtGKCDDkOJwdmJGK1v7pi/zNIf15dwwMmGqkFS5\nZ+Xtr6VD+xxPrXimEOAUnOPP4+A1847YbIkCAjfVeKyFRJ0kfOICVuSPhHhRVPXX\nRjR1mxQOBN6CIT3UNaLJ9JU9gzpzFIESHjuo1NwhyJJMYON0Bu+90oH9KSF1wVXm\nbRG6XCbwqH/QvMdBoEH2lbzmiE/maI/kosGuc0n4846bhkFk86LiK9b8wqHiUTS9\nZjZFfwj1az5/Ajy8NBIy2GAQ0hjnFoibe9KUsrQA/1kP2xbj5Pbw2pKG5lUmAVP4\ni3DSba5qZ31l6lOz7z2nMFFVzwNWQKT4CDokFrvKsQKBgQD/qyoD1D/Ri3TYGEYw\niaKzA7ee5Mk8/PPVqHU3LEg5+VvI1fh7tMuHKk4+bR/XQ/DDxy0TQ0LKkFRuMgYR\nS0FEks50YiE8hUIWwoHLGCo08ib5zNL0mdsWQSBIVqMMzOWqZD2qseZrDyBmUTZG\nTayzxfgNWZiVgTR9ZCPb7uwcgwKBgQDR7f0DAxMwntX9tx9IyjugCukN4GekoW3Y\netE4AGQU5LGyAIjmIOewe8F6rg7sCyhIMhUoopvCl5sqOEdEIUl2ZD3OqCfcOjK+\nXlx1KruVdAMMqCZ76rl3Vk0S5WXNecflJcNClEaS/MDY74V3hlDPcL9kyt6fGQNb\n10k+PS3uCQKBgQD1C7sDXIWmc8GT9QAhOWoFpkRyONpgaBnU6NcgAINhfYzpW5wE\nBW8lp/jCgJkKHAZBvz+GvOrhd6BU1gFWxghSj1rt1bgBZ7/GTLtWS1z4zjdpKVXw\nNx7zn4wviUpR1Hkz7UvltQkiB6eIKcKZc41Z6R8svHkwolwK6tYr0D3hvQKBgDzs\nDu/v1YLXpYxit059ef5BDE89n3ZUbrdTNSJGYsT5dWQN6ay3QeWilIyQtL3lowQI\nnMFVJ1S6gIopGO15p4MXJiSyAhdUQGOkqLpL83I036mtprVxce9i+S0Rq5CM1ej3\nI4pP04dWmHScViRQs2Tv+Gs8wIx1Stc9TAEm6gxZAoGAIujY1HwcC4pJhUjAoEbJ\nofd6XgvKCJnenQBefI5XvYXNuMO3IALBb4TEekL1vrCEeHCu0JjkGiJvv2GPelOW\nvVyslXtMF0fPBshIbaJU6NsF2Hd9qN9owp4GIEorCNt140fO67riNJjqR1vA865n\n36tpgBQTqB6vZCzPuCbqlSI=\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-fbsvc@shopapp27-8bfd7.iam.gserviceaccount.com",
        "client_id": "117561021810333930381",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40shopapp27-8bfd7.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com",
      }),

      scopes,
    );
     final accessServerKey =client.credentials.accessToken.data;
    return accessServerKey;
  }
}
