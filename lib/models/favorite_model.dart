class MyFavorite{
  int id;
  String movieId;
  String movieName;
  String moviePoster;
  String movieRate;

  MyFavorite(
      this.id,
      this.movieId,
      this.movieName,
      this.moviePoster,
      this.movieRate,
      );

  MyFavorite.fromJson(Map<dynamic, dynamic> json)
      :id=json['id'],
        movieId=json['movieId'],
        movieName=json['movieName'],
        moviePoster=json['moviePoster'],
        movieRate=json['movieRate'];
  Map<String, Object?> toJson(){
    return{
      'id':id,
      'movieId':movieId,
      'movieName':movieName,
      'moviePoster':moviePoster,
      'movieRate':movieRate,
    };
  }

}