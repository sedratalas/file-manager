mixin TypeHelper{
  String getFileTypeIcon(String path) {
    final extension = path.split('.').last.toLowerCase();

    if (['jpg', 'jpeg', 'png', 'gif'].contains(extension)) {
      return 'assets/icons/photos.png'; // أيقونة الصور
    } else if (['mp4', 'avi', 'mov'].contains(extension)) {
      return 'assets/icons/video.png'; // أيقونة الفيديو
    } else if (['mp3', 'wav'].contains(extension)) {
      return 'assets/icons/music.png'; // أيقونة الموسيقى
    // } else if (['pdf'].contains(extension)) {
    //   return 'assets/icons/pdf.png'; // أيقونة PDF
    } else if (['doc', 'docx', 'txt'].contains(extension)) {
      return 'assets/icons/files.png'; // أيقونة مستندات
    } else {
      return 'assets/icons/files.png'; // افتراضي
    }
  }

}