import 'package:flutter/material.dart';

class MovieSearchTextfield extends StatefulWidget {
  final Function(String) onChanged;
  final Function(String) onTap;

  const MovieSearchTextfield({super.key, required this.onChanged, required this.onTap});

  @override
  State<MovieSearchTextfield> createState() => _MovieSearchTextfieldState();
}

class _MovieSearchTextfieldState extends State<MovieSearchTextfield> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search movies...',
        filled: true,
        fillColor: Colors.grey[250],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        suffixIcon: IconButton(
          onPressed: (){
            if(controller.text.isEmpty){
              const snackBar = SnackBar(content: Text("Movie name can't be empty"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
            }
            widget.onTap(controller.text);
          },
          icon: const Icon(Icons.search)
        )
      ),
      onChanged: widget.onChanged,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}
