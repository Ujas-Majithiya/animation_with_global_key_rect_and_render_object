import 'package:flutter/material.dart';

class GetBtnRow extends StatelessWidget {
  const GetBtnRow({
    Key? key,
    this.isGetBtnAhead = true,
    this.showShareIcon = true,
  }) : super(key: key);

  final bool isGetBtnAhead;
  final bool showShareIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!isGetBtnAhead) ...[
          RichText(
            text: const TextSpan(
              text: 'In-App\n',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: 'Purchases',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              fixedSize: const Size(100, 25)),
          child: const Text(
            'GET',
            style: TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(width: 8),
        if (isGetBtnAhead) ...[
          RichText(
            text: const TextSpan(
              text: 'In-App\n',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: 'Purchases',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
        if (showShareIcon) ...[
          const Spacer(),
          const Icon(
            Icons.ios_share,
            color: Colors.blue,
          ),
          const SizedBox(width: 16),
        ]
      ],
    );
  }
}
