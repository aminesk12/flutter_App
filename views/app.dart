import 'package:e_shop/dal/post_dao.dart';
import 'package:e_shop/dal/user_dao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dal/photo_dao.dart';
import '../providers/photo_provider.dart';
import '../providers/post_provider.dart';
import '../providers/user_provider.dart';
import '../values/theme.dart';
import 'home.dart';


class Auth extends StatelessWidget {
  final PhotoDao photoDao;
  final UserDao userDao;
  final PostDao postDao;
  const Auth(this.photoDao, this.userDao, this.postDao, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PhotoProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'e-shop',
        debugShowCheckedModeBanner: false,
        theme: themeApp,
        home: ScreenAuth(photoDao, userDao, postDao),
      ),
    );
  }
}

class ScreenAuth extends StatefulWidget {
  final PhotoDao photoDao;
  final UserDao userDao;
  final PostDao postDao;
  const ScreenAuth(this.photoDao, this.userDao, this.postDao, {super.key});

  @override
  State<ScreenAuth> createState() => _ScreenAuthState();
}

class _ScreenAuthState extends State<ScreenAuth> {
  var isAuth = true;
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication',
            style: TextStyle(
              color: Colors.white,
            )),
        leading: GestureDetector(
            onTap: () => _showDialog(context), child: const Icon(Icons.menu)),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.95,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.login_rounded,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                child: Column(
                  children: [
                    TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.email),
                          hintText: 'Enter email',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              TextField(
                obscureText: true,
                controller: _password,
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.password_rounded),
                    hintText: 'Enter password',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2,
                            color: Theme.of(context).colorScheme.inversePrimary),
                        borderRadius: BorderRadius.circular(10))),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                  onPressed: () {
                    _auth();
                  },
                  child: const Text('Login')),
              Text(
                isAuth ? '' : 'Email or password is incorrect',
                style: themeApp.textTheme.bodyMedium,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _auth() {
    setState(() {
      if (_email.text.isEmpty || _password.text.isEmpty) {
        isAuth = false;
      } else {
        isAuth = true;
       
        if (Provider.of<UserProvider>(context, listen: false)
            .authenticate(_email.text, _password.text)) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (_) => PostProvider()),
                ],
                child: DashBoard(postdao: widget.postDao,lastName:  Provider.of<UserProvider>(context, listen: false).getLastName(_email.text)),
              ),
            ),
          );
        } else {
          isAuth = false;
        }
      }
    });
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: themeApp.appBarTheme.backgroundColor,
        title: Text(
          'Test Menu',
          style: themeApp.textTheme.titleMedium,
        ),
        content: Text('Menu clicked', style: themeApp.textTheme.titleMedium),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Ok'),
          )
        ],
      ),
    );
  }
}
