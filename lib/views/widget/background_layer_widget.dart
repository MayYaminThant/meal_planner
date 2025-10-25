import '../../components/export_files.dart';

class BackgroundLayerWidget extends StatelessWidget {
  const BackgroundLayerWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeMedia.screenWidth(context),
      margin: const EdgeInsets.only(top: 65),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: child,
    );
  }
}
