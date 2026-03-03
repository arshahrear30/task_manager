import 'package:flutter/material.dart';
import 'package:task_manager/ui/widget/body_background.dart';
import 'package:task_manager/ui/widget/profile_summary_card.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _createTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: BodyBackground(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      
                          const SizedBox(height: 32,),
                          Text('Add New Task', style: Theme
                              .of(context)
                              .textTheme
                              .titleLarge,),
                          const SizedBox(height: 32,),
                      
                          TextFormField(
                            controller: _subjectTEController,
                            decoration: const InputDecoration(
                              hintText: 'Subject',
                            ),
                              validator: (String? value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return 'Enter your subject';
                                }
                                return null;
                              },
                          ),
                      
                      
                          const SizedBox(height: 16,),
                          TextFormField(
                            controller: _descriptionTEController,
                            maxLines: 8,
                            decoration: const InputDecoration(
                              hintText: 'Description',
                            ),

                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Enter your subject';
                              }
                              return null;
                            },

                          ),
                          const SizedBox(height: 16,),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: createTask,
                              child: const Icon(
                                  Icons.arrow_circle_right_outlined),
                            ),

                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> createTask() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }


    }




  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }

}