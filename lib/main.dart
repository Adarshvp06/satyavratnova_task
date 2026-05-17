import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:satyavratnova_task/route/app_route.dart';

import 'core/theme/app_theme.dart';
import 'features/home/viewmodel/home_viewmodel.dart';
import 'features/navigation/viewmodel/navigation_viewmodel.dart';
import 'core/services/location_service.dart';
import 'core/services/permission_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            Provider(create: (_) => PermissionService()),
            Provider(create: (_) => LocationService()),
            ChangeNotifierProvider(
              create: (context) => NavigationViewModel(
                permissionService: context.read<PermissionService>(),
                locationService: context.read<LocationService>(),
              ),
            ),
            ChangeNotifierProvider(create: (_) => HomeViewModel()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.themeData,
            onGenerateInitialRoutes: AppRoute.onGenerateInitialRoute,
            onGenerateRoute: AppRoute.onGenerateRoute,
          ),
        );
      },
    );
  }
}
