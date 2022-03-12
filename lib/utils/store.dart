import 'package:nepaltourisguide/models/bagmatimodel.dart';
import 'package:nepaltourisguide/models/province1model.dart';
import 'package:nepaltourisguide/models/province2model.dart';
import 'package:velocity_x/velocity_x.dart';

class MyStore extends VxStore {
  PopularModel? province1;
  Province2Model? province22;
  BagmatiModel? bagmati;
  MyStore() {
    province1 = PopularModel();
    province22 = Province2Model();
    bagmati = BagmatiModel();
  }
}
