class ArrayUtils{
  static getFirstElement(List? list) {
    if (list != null) {
      if (list.isNotEmpty) {
        return list[0];
      }
      return null;
    }
    return null;
  }

  static int size({List? list}) {
    if (list != null) {
      return list.length;
    }
    return 0;
  }
}