import 'package:flutter/material.dart';

class PillsWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onPillSelected;

  const PillsWidget({
    Key? key,
    required this.selectedIndex,
    required this.onPillSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pills = ['Report New', 'Reported', 'Chatbot'];

    return SizedBox(
      height: 32,
      child: Row(
        children: [
          for (int i = 0; i < pills.length; i++) ...[
            Expanded(
              child: GestureDetector(
                onTap: () => onPillSelected(i),
                child: Container(
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: selectedIndex == i
                        ? const Color(0xFF087A84)
                        : const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      pills[i],
                      style: TextStyle(
                        color: selectedIndex == i
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (i < pills.length - 1) const SizedBox(width: 12),
          ],
        ],
      ),
    );
  }
}