import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../../../core/router/app_router.dart';

class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({super.key});

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final _phoneController = TextEditingController();
  String _selectedCountry = 'SA';
  String _countryCode = '+966';

  final List<Map<String, String>> _countries = [
    {'code': 'SA', 'name': 'السعودية', 'dial': '+966'},
    {'code': 'AE', 'name': 'الإمارات', 'dial': '+971'},
    {'code': 'EG', 'name': 'مصر', 'dial': '+20'},
    {'code': 'KW', 'name': 'الكويت', 'dial': '+965'},
    {'code': 'QA', 'name': 'قطر', 'dial': '+974'},
    {'code': 'BH', 'name': 'البحرين', 'dial': '+973'},
    {'code': 'OM', 'name': 'عمان', 'dial': '+968'},
    {'code': 'JO', 'name': 'الأردن', 'dial': '+962'},
    {'code': 'IQ', 'name': 'العراق', 'dial': '+964'},
    {'code': 'LY', 'name': 'ليبيا', 'dial': '+218'},
    {'code': 'TN', 'name': 'تونس', 'dial': '+216'},
    {'code': 'DZ', 'name': 'الجزائر', 'dial': '+213'},
    {'code': 'MA', 'name': 'المغرب', 'dial': '+212'},
    {'code': 'YE', 'name': 'اليمن', 'dial': '+967'},
    {'code': 'SD', 'name': 'السودان', 'dial': '+249'},
    {'code': 'LB', 'name': 'لبنان', 'dial': '+961'},
    {'code': 'SY', 'name': 'سوريا', 'dial': '+963'},
    {'code': 'PS', 'name': 'فلسطين', 'dial': '+970'},
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'اختر الدولة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: _countries.length,
                itemBuilder: (context, index) {
                  final country = _countries[index];
                  return ListTile(
                    leading: Text(
                      country['code']!,
                      style: const TextStyle(fontSize: 24),
                    ),
                    title: Text(country['name']!),
                    trailing: Text(
                      country['dial']!,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedCountry = country['code']!;
                        _countryCode = country['dial']!;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitPhone() {
    final phone = _phoneController.text.trim();
    if (phone.length < 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال رقم هاتف صحيح')),
      );
      return;
    }
    
    final fullPhone = '$_countryCode$phone';
    context.read<AuthBloc>().add(SendOtp(fullPhone));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is OtpSent) {
          Navigator.pushNamed(
            context,
            AppRouter.otpVerification,
            arguments: {'phone': state.phoneNumber},
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('إدخال رقم الهاتف'),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'سنرسل لك رمز التحقق عبر رسالة نصية',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              // Country selector
              InkWell(
                onTap: _showCountryPicker,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _countries.firstWhere(
                          (c) => c['code'] == _selectedCountry,
                        )['name']!,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Phone input
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _countryCode,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 9,
                      decoration: InputDecoration(
                        hintText: '5XX XXX XXX',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        counterText: '',
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitPhone,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF25D366),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator(
                          color: Colors.white,
                        );
                      }
                      return const Text(
                        'التالي',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
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
