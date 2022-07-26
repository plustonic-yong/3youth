import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:goh/screens/home_screen.dart';
import 'package:goh/screens/user/component/initial_register_user_input_form.dart';

class InitialRegisterUserInfo extends StatefulWidget {
  const InitialRegisterUserInfo({Key? key}) : super(key: key);

  @override
  State<InitialRegisterUserInfo> createState() =>
      _InitialRegisterUserInfoState();
}

class _InitialRegisterUserInfoState extends State<InitialRegisterUserInfo> {
  int _currentPage = 0;
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
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.fill,
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
                      'assets/icons/logo.png',
                      width: 110.0,
                    ),
                    const SizedBox(height: 155.0),
                    Text(
                      _currentPage == 0
                          ? '당신의 이름은 무엇인가요?'
                          : _currentPage == 1
                              ? '키는 몇이신가요?'
                              : _currentPage == 2
                                  ? '몸무게는 어떻게 되세요?'
                                  : '생년월일과 성별을 입력해주세요.',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                    const SizedBox(height: 50.0),
                    //input form
                    // Expanded(
                    //   child: PageView(
                    //     scrollBehavior: ScrollBehavior(),
                    //     children: [
                    //     ],
                    //   ),
                    // ),

                    InputForm(page: _currentPage),
                    const Spacer(),
                    //dots indicator
                    DotsIndicator(
                      dotsCount: 4,
                      position: _currentPage.toDouble(),
                      decorator: DotsDecorator(
                        size: const Size.square(9.0),
                        activeSize: const Size(30.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //이전버튼
                        _currentPage != 0
                            ? GestureDetector(
                                onTap: () {
                                  if (_currentPage > 0) {
                                    setState(() {
                                      _currentPage--;
                                    });
                                  }
                                },
                                child: Container(
                                  width: 190.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff)
                                        .withOpacity(0.3),
                                    boxShadow: const [
                                      BoxShadow(
                                        // ignore: use_full_hex_values_for_flutter_colors
                                        color: Color(0xff00000029),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        // changes position of shadow
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '이전',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        const SizedBox(width: 20.0),
                        //다음버튼
                        GestureDetector(
                          onTap: () {
                            if (_currentPage < 3) {
                              setState(() {
                                _currentPage++;
                              });
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: _currentPage == 0 ? 268.0 : 190.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [
                                  0.05,
                                  0.5,
                                ],
                                colors: [
                                  Color(0xff46DFFF),
                                  Color(0xff00B1E9),
                                ],
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  // ignore: use_full_hex_values_for_flutter_colors
                                  color: Color(0xff00000029),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
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
                      ],
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
