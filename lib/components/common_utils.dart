import '../components/export_files.dart';

class CommonUtils {
  static void showAlertDialogWithOkButton({
    BuildContext? context,
    String? title,
    String? content,
    Function()? callback,
  }) {
    if (context != null ||
        NavigationService.navigatorKey.currentContext != null) {
      showGeneralDialogWidget(
        context ?? NavigationService.navigatorKey.currentContext!,
        (context, animation, secondaryAnimation) => AlertDialog(
          title: title != null ? Text(title) : null,
          content: content != null ? Text(content) : null,
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
                callback?.call();
              },
            ),
          ],
        ),
      );
    }
  }

  static Future<Object?> showGeneralDialogWidget(
    BuildContext mainContext,
    Widget Function(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) pageBuilder,
  ) {
    return showGeneralDialog(
      context: mainContext,
      barrierDismissible: true,
      barrierLabel: "Label",
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
      pageBuilder: pageBuilder,
    );
  }
}
