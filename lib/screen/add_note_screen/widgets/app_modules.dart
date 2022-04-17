import 'package:flutter/material.dart';

class ClearButton extends StatelessWidget {
  const ClearButton({
    Key? key,
    required this.contentController,
  }) : super(key: key);

  final TextEditingController contentController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            //a button to clear all text from content section
            contentController.clear();
          },
          icon: const Icon(
            Icons.clear,
            size: 18,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 30)
      ],
    );
  }
}

class BodyTextField extends StatelessWidget {
  const BodyTextField({
    Key? key,
    required this.contentController,
  }) : super(key: key);

  final TextEditingController contentController;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: double.infinity,
        ),
        width: 323,
        decoration: BoxDecoration(
            color: const Color(0xFF3B3A4D),
            borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Expanded(
            child: TextField(
              controller: contentController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Body Text\n',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 161, 157, 177),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class HeadTextField extends StatelessWidget {
  const HeadTextField({
    Key? key,
    required this.titleController,
  }) : super(key: key);

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 323,
      decoration: BoxDecoration(
          color: const Color(0xFF3B3A4D),
          borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: TextField(
          controller: titleController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Header Text',
              hintStyle: TextStyle(
                  color: Color.fromARGB(255, 161, 157, 177),
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
