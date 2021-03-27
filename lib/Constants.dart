class Constants {
  static int id;
  Constants({this.trailer});
  static const String PopularApi =
      'https://api.themoviedb.org/3/movie/popular?api_key=43c2d4363a23701a9b104a82330340f9';
  static const String TrendingApi =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=43c2d4363a23701a9b104a82330340f9';
  static const String imagesApi = 'https://image.tmdb.org/t/p/w500/';
  String trailer =
      'http://api.themoviedb.org/3/movie/$id/videos?api_key=43c2d4363a23701a9b104a82330340f9';
}
