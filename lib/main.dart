import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'data/datasources/local/database_helper.dart';
import 'presentation/bookmarks/cubit/bookmarks_cubit.dart';
import 'presentation/splash/splash_screen.dart';
import 'presentation/users/cubit/users_cubit.dart';
import 'utils/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UsersCubit()..init()),
        BlocProvider(
          create: (context) =>
              BookmarksCubit(DatabaseHelper.instance)..loadBookmarkedUsers(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(theme: AppTheme.lightTheme(), home: child);
        },
        child: const SplashScreen(),
      ),
    );
  }
}
