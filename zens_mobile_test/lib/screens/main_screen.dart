import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zens_mobile_test/core/extensions/extensions.dart';
import 'package:zens_mobile_test/core/provider/joke_provider.dart';
import 'package:zens_mobile_test/gen/assets.gen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JokerProvider(),
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            const _Header(),
                            const _Banner(),
                            const _Content(),
                            Selector<JokerProvider, List<String>>(
                              selector: (provider, value) {
                                return value.unVotedList;
                              },
                              builder: (context, value, _) {
                                if (value.isEmpty) return const SizedBox();

                                return const _Button();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const _Footer()
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 0.5),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: Text(
            'This appis created as part of HIsolutions program.The materials contained on this website are provided for general information only anddo not constitute any form of advice. HLS assumes no responsibilityfor the accuracy of any particular statement and accepts no liabilityfor any loss or damage which may arise from reliance on the infor-mation contained on this site.',
            textAlign: TextAlign.center,
            style: context.labelSmall.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Center(
          child: Text(
            'Copyright 2021 HLS',
            style: context.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Divider(thickness: 1.5),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      child: Row(
        children: [
          Expanded(
            child: MaterialButton(
              onPressed: () {
                context.read<JokerProvider>().voted();
              },
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
              ),
              color: const Color(0xff2C7FDB),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'This is Funny!',
                  style: context.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: MaterialButton(
              onPressed: () {
                context.read<JokerProvider>().voted();
              },
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
              ),
              color: const Color(0xff2AB363),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'This is not funny .',
                  style: context.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 20.w,
        ),
        child: Center(
          child: Selector<JokerProvider, List<String>>(
            selector: (provider, value) {
              return value.unVotedList;
            },
            builder: (context, value, _) {
              if (value.isEmpty) {
                return Text(
                  '''That's all the jokes for today!\n Come back another day!''',
                  textAlign: TextAlign.center,
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff6E6E6E),
                  ),
                );
              }

              return Text(
                value.first,
                style: context.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff6E6E6E),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xff2AB363),
      child: SizedBox(
        height: 150.h,
        width: context.width,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'A joke a day keeps the doctor away',
                  style: context.bodyLarge.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'If you joke wrong way, your teeth have to pay. (Serious)',
                  style: context.bodyMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox.square(
                dimension: 50.r,
                child: Assets.logo.image(),
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Handicrafted by',
                      style: context.bodyMedium.copyWith(
                        color: const Color(0xff999999),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text('Jim HLS'),
                  ],
                ),
                SizedBox.square(
                  dimension: 50.r,
                  child: Assets.createByIcon.image(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
