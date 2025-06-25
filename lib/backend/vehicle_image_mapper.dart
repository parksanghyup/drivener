
// 차량 이미지 매핑 유틸리티
String getVehicleImagePath(String uidOrCarNumber) {
  // 예시: UID 앞자리나 차량 번호 패턴에 따라 차량 이미지 선택
  if (uidOrCarNumber.contains('SUV') || uidOrCarNumber.startsWith('S')) {
    return 'assets/images/suv.png';
  } else if (uidOrCarNumber.contains('SEDAN') || uidOrCarNumber.startsWith('D')) {
    return 'assets/images/sedan.png';
  } else if (uidOrCarNumber.contains('TRUCK') || uidOrCarNumber.startsWith('T')) {
    return 'assets/images/truck.png';
  } else if (uidOrCarNumber.contains('BIKE') || uidOrCarNumber.startsWith('B')) {
    return 'assets/images/bike.png';
  } else {
    return 'assets/images/default_car.png';
  }
}
