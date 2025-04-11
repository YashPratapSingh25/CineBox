import 'package:cinebox/widgets/account_textfield.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? selectedGender;
  String? selectedState;
  String? selectedCity;

  final List<String> genders = ['Male', 'Female', 'Other'];
  final Map<String, List<String>> stateCityMap = {
    'Uttar Pradesh': ['Lucknow', 'Kanpur', 'Noida'],
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur'],
    'Delhi': ['New Delhi'],
  };

  InputDecoration dropdownDecoration(String label) {
    return const InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF10141E),
      appBar: AppBar(
        title: const Text('Account Details', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF10141E),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              AccountTextfield(controller: _nameController, label: 'Name'),
              const SizedBox(height: 16),
              AccountTextfield(controller: _emailController, label: 'Email', email: true),
              const SizedBox(height: 16),
              AccountTextfield(controller: _phoneController, label: 'Phone', phone: true),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedGender,
                dropdownColor: Colors.black,
                decoration: dropdownDecoration("Select Gender"),
                hint: const Text("Gender", style: TextStyle(color: Colors.white)),
                onChanged: (val) => setState(() => selectedGender = val),
                items: genders.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender, style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Please select your gender' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedState,
                dropdownColor: Colors.black,
                decoration: dropdownDecoration("Select State"),
                hint: const Text("State", style: TextStyle(color: Colors.white)),
                onChanged: (val) {
                  setState(() {
                    selectedState = val;
                    selectedCity = null;
                  });
                },
                items: stateCityMap.keys.map((state) {
                  return DropdownMenuItem(
                    value: state,
                    child: Text(state, style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Please select a state' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCity,
                dropdownColor: Colors.black,
                decoration: dropdownDecoration("Select City"),
                hint: const Text("City", style: TextStyle(color: Colors.white)),
                onChanged: (val) => setState(() => selectedCity = val),
                items: (stateCityMap[selectedState] ?? []).map((city) {
                  return DropdownMenuItem(
                    value: city,
                    child: Text(city, style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Please select a city' : null,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.deepPurple
                  ),
                  child: const Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  _formKey.currentState!.reset();
                  _nameController.clear();
                  _emailController.clear();
                  _phoneController.clear();
                  setState(() {
                    selectedGender = null;
                    selectedState = null;
                    selectedCity = null;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.redAccent,
                  ),
                  child: const Center(
                    child: Text(
                      'Clear',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
