class Transactions {
  String title; //ชื่อ
  String lastname;
  String address;
  // String phone;
  double amount; //จำนวนเงิน
  DateTime date; //วันที่ เวลา บันทึกรายการ

  Transactions(
      {this.title, this.lastname, this.address, this.amount, this.date});
}
