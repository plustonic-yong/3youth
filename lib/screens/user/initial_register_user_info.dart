import 'package:flutter/material.dart';

class InitialRegisterUserInfo extends StatefulWidget {
  const InitialRegisterUserInfo({Key? key}) : super(key: key);

  @override
  State<InitialRegisterUserInfo> createState() =>
      _InitialRegisterUserInfoState();
}

class _InitialRegisterUserInfoState extends State<InitialRegisterUserInfo> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            //배경이미지
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/main_background1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //contents
            SafeArea(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const SizedBox(height: 140.0),
                    //로고
                    Image.asset(
                      'assets/icons/menu.png',
                      width: 110.0,
                    ),
                    const SizedBox(height: 155.0),
                    const Text(
                      '당신의 이름은 무엇인가요?',
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                    const SizedBox(height: 50.0),
                    //이름
                    SizedBox(
                      width: 308.0,
                      height: 50.0,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: '이름',
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    //다음버튼
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 190.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0XFF3DBFFF),
                              Color(0XFF00B1E9),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              // ignore: use_full_hex_values_for_flutter_colors
                              color: Color(0xff00000029),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: const Center(
                          child: Text(
                            '다음',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
