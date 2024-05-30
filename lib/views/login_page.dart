import 'package:flutter/material.dart';
import 'package:responsi_tpm/views/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    // Implementasi login sederhana (tanpa validasi sebenarnya)
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Jika username sama dengan 'admin' dan password sama dengan 'admin', arahkan ke halaman beranda
    if (username == 'admin' && password == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Jika username dan password salah, popup snackbar akan muncul
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Username or password is incorrect.'),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          // Membuat card centered
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Memberikan padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment
                  .center, // Meletekkan posisi card di center body
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, // Memberikan lebar yang fleksibel pada widget/elemen
              children: <Widget>[
                Card(
                  elevation: 5, // Memberikan bayangan pada card
                  child: Padding(
                    padding: const EdgeInsets.all(20.0), // Memberikan padding
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Meletakkan posisi elemen di tengah card
                      crossAxisAlignment: CrossAxisAlignment
                          .stretch, // Memberikan lebar yang fleksibel pada widget/elemen
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Welcome to Valorant App',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors
                                    .black, // You can set the color of the line here
                                width:
                                    2.0, // You can set the width of the line here
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25.0),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            hintText: 'Enter username',
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: 'Enter password',
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(
                          // Membuat widget yang bisa di custom ukurannya (height)
                          height: 40.0,
                          child: ElevatedButton(
                            onPressed: () => _login(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
