import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? leadingImagePath;
  final String? trailingImagePath ;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onTrailingTap;

  const CustomAppBar({
    super.key,
    required this.title,
 this.leadingImagePath,
     this.trailingImagePath,
    this.onLeadingTap,
    this.onTrailingTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 41);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 41),
      child: SizedBox(
        height: kToolbarHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Title
            Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),

            // Leading Icon
            Align(
              alignment: Alignment.centerLeft,
              child: leadingImagePath != null
                  ? GestureDetector(
                onTap: onLeadingTap,
                child: Container(
                  height: 36,
                  width: 36,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0x80FFFFFF), // Transparent white
                  ),
                  child: Image.asset(
                    leadingImagePath!,
                    height: 14,
                    width: 14,
                    fit: BoxFit.contain,
                  ),
                ),
              )
                  : const SizedBox(), // empty space if no leading icon
            ),


            // Trailing Icon
            Align(
              alignment: Alignment.centerRight,
              child: trailingImagePath != null
                  ? GestureDetector(
                onTap: onTrailingTap,
                child: Container(
                  height: 36,
                  width: 36,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0x80FFFFFF), // Transparent white
                  ),
                  child: Image.asset(
                    trailingImagePath!,
                    height: 14,
                    width: 14,
                    fit: BoxFit.contain,
                  ),
                ),
              )
                  : const SizedBox(), // empty space if no trailing icon
            ),

          ],
        ),
      ),
    );
  }
}
