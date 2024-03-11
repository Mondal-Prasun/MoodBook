import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_book/model/mood_model.dart';
import 'package:mood_book/provider/data_provider.dart';

class EditDescripTion extends ConsumerStatefulWidget {
  const EditDescripTion({
    super.key,
    required this.description,
    required this.moodModel,
  });
  final String description;
  final MoodModel moodModel;
  @override
  ConsumerState<EditDescripTion> createState() {
    return _EditDescripTionState();
  }
}

class _EditDescripTionState extends ConsumerState<EditDescripTion> {
  bool _isEditable = false;
  late TextEditingController textEditingController;
  late String _initialText;
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.description);
    _initialText = widget.description;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fromKey = GlobalKey<FormState>();

    void onSave() {
      if (fromKey.currentState!.validate()) {
        fromKey.currentState!.save();
        Navigator.of(context).pop();
      }
    }

    Widget _editTableTextField() {
      if (_isEditable) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 240,
              ),
              child: Form(
                key: fromKey,
                child: TextFormField(
                  autofocus: true,
                  controller: textEditingController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value == "" ||
                        value.length < 5 ||
                        value.isEmpty) {
                      return "Please add some description(atleast 5 charecter long)";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _initialText = value!;
                      ref.read(dataProvider.notifier).saveEditText(
                            widget.moodModel,
                            value,
                          );
                      _isEditable = false;
                    });
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 220,
              right: 0,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  foregroundColor: Colors.white,
                ),
                onPressed: onSave,
                icon: const Icon(Icons.system_update_tv_rounded),
                label: const Text("Save"),
              ),
            ),
          ],
        );
      }
      return InkWell(
        onLongPress: () {
          setState(() {
            _isEditable = true;
          });
        },
        child: Text(
          _initialText,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
              ),
        ),
      );
    }

    return _editTableTextField();
  }
}
