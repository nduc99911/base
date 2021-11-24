

class AlertDialogAnimated {
  static AlertDialogAnimated? alertDialogAnimated;

  static AlertDialogAnimated getInstance() {
    if (alertDialogAnimated == null) {
      alertDialogAnimated = AlertDialogAnimated();
    }
    return alertDialogAnimated!;
  }
}
