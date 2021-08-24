abstract class HomeDatasource {
  Future getPictures(int quantityOfPictures);
  Future filterByDate(String dateFilter);
}
