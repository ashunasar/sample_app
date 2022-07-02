import 'package:get/get_navigation/src/routes/get_route.dart';
import '../modules/onboard/onboarding_returning_user.view.dart';
import '../modules/splash_screen/view/splash_screen.view.dart';

class Routes {
  static const splashRoute = "/splash";
  static const loginRoute = "/login";
  static const homeRoute = "/home";
  static const authRoute = "/authentication";
  static const signUpRoute = "/sign_up";
  static const enterPhoneNumberRoute = "/enter_phone_number";
  static const enterPhoneNumberRoute2 = "/enter_phone_number2";
  static const verifyPhoneNumberRoute = "/verify_phone_number";
  static const authFlow2Route = "/authentication_flow_2";
  static const userInfoRoute = "/userInfoView";
  static const createLinkRoute = "/create_new_link";
  static const addNewLinkRoute = "/add_new_link";
  static const forgotPasswordRoute = "/forgot_password";
  static const receiveOTPRoute = "/receive_otp";
  static const enterNewPasswordRoute = "/enter_new_password";
  static const previewProfileRoute = "/preview_profile_view";
  static const profileRoute = "/profile_view";
  static const personalDetailsRoute = "/personal_details";
  static const contactInfoRoute = "/contact_info";
  static const featuredVideoRoute = "/featured_video";
  static const allLinkRoute = "/all_video";
  static const onBoardRoute = "/on_board";
  static const messagesRoute = "/messages";
  static const productRoute = "/product";
  static const vechicleRoute = "/vechicle";
  static const directLinkRoute = "/direct_link";
  static const myQRCodeRoute = "/MyQRCode";
  static const linkQRCodeRoute = "/link_qr_code";
  static const scanQRCodeRoute = "/scan_qr_code";
  static const activateNFCRoute = '/activate_nfc';
  static const notificationRoute = "/notification";
  static const onBoardReturningUserRoute = "/on_board_returning_user";
  static const searchLink = "/add_link";
  static const changeThemeRoute = "/change_theme";
  static const storeRoute = "/store";

  static final pages = [
    GetPage(name: splashRoute, page: () => SplashScreenView()),
    GetPage(
        name: onBoardReturningUserRoute,
        page: () => OnboardingReturningUserView())
  ];
}
