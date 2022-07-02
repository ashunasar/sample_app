import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';

import 'package:caard_frontend_final/presentation/views/dashboard/components/delivery_address.view.dart';
import 'package:caard_frontend_final/presentation/views/product/store.view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:caard_frontend_final/api/direct_link_activate_api.dart';
import 'package:caard_frontend_final/api/direct_link_deactivate_api.dart';
import 'package:caard_frontend_final/api/download_vcard.dart';
import 'package:caard_frontend_final/api/previewprofile_api.dart';
import 'package:caard_frontend_final/app/routes/app.routes.dart';
import 'package:caard_frontend_final/app/shared/colors.dart';
import 'package:caard_frontend_final/app/shared/dimensions.dart';
import 'package:caard_frontend_final/constants/constants.dart';
import 'package:caard_frontend_final/domain/cubit/utility/cubit/utility_cubit.dart';
import 'package:caard_frontend_final/models/previewprofile_class.dart';
// import 'package:caard_frontend_final/models/user.dart';
import 'package:caard_frontend_final/presentation/views/product/product.view.dart';
import 'package:caard_frontend_final/presentation/views/profile/personal_details.view.dart';
import 'package:caard_frontend_final/presentation/views/profile/preview_profile.view.dart';
import 'package:caard_frontend_final/presentation/widgets/custom_buttons.dart';
import 'package:caard_frontend_final/presentation/widgets/custom_icon.dart';
import 'package:caard_frontend_final/presentation/widgets/custom_snack_bar.dart';
import 'package:caard_frontend_final/shared_prefs/shared_prefs.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:sizer/sizer.dart';
import 'package:caard_frontend_final/app/shared/fonts.dart';
import 'package:caard_frontend_final/app/shared/textstyles.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'package:webview_flutter/webview_flutter.dart';

import '../../widgets/custom_app_bar.dart';

class DashboardView extends StatefulWidget {
  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  showDirectLinkAlertDialog(BuildContext context, String title) {
    AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        content: Container(
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close))
                ],
              ),
              Text(title,
                  style: TextStyle(
                      fontFamily: KConstantFonts.OpenSansBold,
                      fontSize: 16,
                      color: KConstantColors.darkColor)),
              vSizedBox1,
              Text("""This mode allows you to select a 
distinguished platform of your choice 
which you think is the most relevent to 
your cause and showcase only that link """,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: KConstantFonts.OpenSans,
                      fontSize: 12,
                      color: KConstantColors.darkColor)),
              vSizedBox2,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code,
                    size: 30,
                  ),
                  hSizedBox1,
                  Icon(Icons.arrow_forward),
                  hSizedBox1,
                  Icon(FontAwesomeIcons.instagram),
                  hSizedBox1,
                  Icon(FontAwesomeIcons.facebook),
                  hSizedBox1,
                  Icon(FontAwesomeIcons.twitter)
                ],
              )
            ],
          ),
        ));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  vechicleModeAlertDialog(
      BuildContext context, String title, String description) {
    AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        content: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close))
                ],
              ),
              Text(title,
                  style: TextStyle(
                      fontFamily: KConstantFonts.OpenSansBold,
                      fontSize: 16,
                      color: KConstantColors.darkColor)),
              vSizedBox1,
              Text(description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: KConstantFonts.OpenSans,
                      fontSize: 12,
                      color: KConstantColors.bgColor)),
              vSizedBox2,
              CustomButtons.roundedCorner(
                  title: "Get your Caard sticker now",
                  onTap: () {},
                  width: 50,
                  height: 5,
                  textStyle: KCustomTextstyle.kBoldWhite(context, 8),
                  context: context,
                  backgroundColor: KConstantColors.bgColor,
                  cornerRadius: 25)
            ],
          ),
        ));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  saveDirectLinkFirstTime(BuildContext context) {
    AlertDialog alert = AlertDialog(
        title: Center(
            child: Text("Attach Direct Link URL",
                style: TextStyle(
                    fontFamily: KConstantFonts.OpenSansBold,
                    fontSize: 14,
                    color: KConstantColors.darkColor))),
        actions: [
          Center(
            child: CustomButtons.roundedCorner(
                title: "Save",
                onTap: () {},
                width: 50,
                height: 5,
                textStyle: KCustomTextstyle.kBoldWhite(context, 10),
                context: context,
                backgroundColor: KConstantColors.darkColor,
                cornerRadius: 30),
          ),
        ],
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(
                    hintText: 'http://www.website.com/varundar...'),
              ),
            )
          ],
        ));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String? url;
  String? name= currentUser!.fullName;
  String? loc= 'Location';
  String? work= 'Occupation';
  File? fileImage;
  bool directLinkActivated= false;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  List<Map<String, dynamic>> socialLinkBlock= [];
  String? links;
  List<dynamic> linksJson=[];

  PreviewProfile? user;
  init() async{
    String? profileUrl= await getProfileImage();
    String? coverUrl= await getCoverImage();
    // String? profileUrl;
    // String? coverUrl;
    getCurrentUser();
    // if(firebaseUser!=null){
    //   return;
    // }
    await getFullProfile(currentUser!.userName).then((value) async{
      user = value;
      File? file;
      if(profileUrl==null){
        if(user!.personalInfo!=null){
          file= await decodeImage(user!.personalInfo!=null ? user!.personalInfo!.imageLocation!=null? user!.personalInfo!.imageLocation! : '' : '');
          saveProfileImage(user!.personalInfo!=null ? user!.personalInfo!.imageLocation!=null ? user!.personalInfo!.imageLocation! : '' : '');
          saveCoverImage(user!.personalInfo!=null ? user!.personalInfo!.coverImageLocation!=null ? user!.personalInfo!.coverImageLocation! : '' : '');
        }
      }else{
        file = await decodeImage(profileUrl);
        saveProfileImage(profileUrl);
        saveCoverImage(user!.personalInfo!=null ? user!.personalInfo!.coverImageLocation!=null ? user!.personalInfo!.coverImageLocation! : '' : '');
      }
      setState(() {
        isLoading = false;
        name= user!.personalInfo!=null ? user!.personalInfo!.name : null;
        fileImage= file;
        work= user!.personalInfo!=null? user!.personalInfo!.work: 'Occupation';
        loc= user!.personalInfo!=null? user!.personalInfo!.location: 'Location';
        directLinkActivated = user!=null ? user!.directLink : false;
        links= user!.links!=null ? user!.links! : null;
        convertStringToList();
        initialiseLinks();
        socialLinkBlock= linkBlock;
      });
    });
  }
   User? firebaseUser;
  getCurrentUser() async{
    firebaseUser = FirebaseAuth.instance.currentUser;
    print(firebaseUser);
  }

  convertStringToList(){
    if(links!=null){
      linksJson= jsonDecode(links!);
    }
  }

  Future<File?> decodeImage(String imgUrl) async{
    if(imgUrl.isEmpty){
      return null;
    }
    final decodedBytes = base64Decode(imgUrl);
    final directory= await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/decoded.png");
    file.writeAsBytesSync(List.from(decodedBytes));
    return file;
  }

  List<Map<String, dynamic>> linkBlock= [];
  initialiseLinks(){
    linksJson.forEach((key) {
      if(key['Name']=='Contacts'){
        linkBlock.add({
          'title': 'Contacts',
          'order': 0,
          'color': KConstantColors.blueColor,
          'icon': 'assets/icons/Contact.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            // downloadVCard().then((value) {
            //   print(value);
            // });
            print('https://$key[\'URL\']');
            await launch('https://$key[\'URL\']');
          }
        });
      }
      if(key['Name']=='Instagram'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': KConstantColors.redColor,
          'icon': 'assets/icons/Instagram.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Facebook'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.blueAccent,
          'icon': 'assets/icons/Facebook.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Twitter'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': KConstantColors.blueColor,
          'icon': 'assets/icons/Twitter.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Behance'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.black,
          'icon': 'assets/icons/Behance.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Dribbble'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.pink,
          'icon': 'assets/icons/Dribbble.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Snapchat'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.yellow,
          'icon': 'assets/icons/Snapchat.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Whatsapp'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.green,
          'icon': 'assets/icons/Whatsapp.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Telegram'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.blue,
          'icon': 'assets/icons/Telegram.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Signal'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.lightBlueAccent,
          'icon': 'assets/icons/Signal.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Linkedin'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.lightBlueAccent,
          'icon': 'assets/icons/LinkedIn.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Youtube'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.red,
          'icon': 'assets/icons/Youtube.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Tumblr'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.blueAccent,
          'icon': 'assets/icons/Tumblr.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Tiktok'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.black,
          'icon': 'assets/icons/Tik Tok.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Reddit'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.deepOrange,
          'icon': 'assets/icons/Reddit.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Pinterest'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.red,
          'icon': 'assets/icons/Pinterest.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Medium'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.black,
          'icon': 'assets/icons/Medium.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Clubhouse'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.white70,
          'icon': 'assets/icons/Clubhouse.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Spotify'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.green,
          'icon': 'assets/icons/Spotify.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Vimeo'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.blue,
          'icon': 'assets/icons/Viemo.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Gmail'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.red,
          'icon': 'assets/icons/Gmail.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Email'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.red,
          'icon': 'assets/icons/Mail.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Paypal'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.blue,
          'icon': 'assets/icons/Paypal.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Kaggle'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.blue,
          'icon': 'assets/icons/Kaggle.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Github'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.black,
          'icon': 'assets/icons/GitHub.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Freelancer'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.blue,
          'icon': 'assets/icons/Freelancer.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Discord'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.blue,
          'icon': 'assets/icons/Discord.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Twitch'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.purpleAccent,
          'icon': 'assets/icons/Twitch.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Etsy'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.orange,
          'icon': 'assets/icons/Etsy.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Yelp'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.orange,
          'icon': 'assets/icons/Yelp.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Soundcloud'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.orange,
          'icon': 'assets/icons/Soundcloud.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Buymeacoffee'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.yellowAccent,
          'icon': 'assets/icons/Buymeacoffee.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Shopify'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.green,
          'icon': 'assets/icons/Shopify.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Airbnb'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.redAccent,
          'icon': 'assets/icons/Airbnb.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Appstore'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.blue,
          'icon': 'assets/icons/App Store.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Skype'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.lightBlueAccent,
          'icon': 'assets/icons/Skype.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Stackoverflow'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.orange,
          'icon': 'assets/icons/Stack Overflow.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Quora'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.red,
          'icon': 'assets/icons/Quora.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Tinder'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.red,
          'icon': 'assets/icons/Tinder.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Blogspot'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.red,
          'icon': 'assets/icons/Blogspot.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Booksy'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.red,
          'icon': 'assets/icons/Booksy.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Bumble'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.red,
          'icon': 'assets/icons/Bumble.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Calendly'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.red,
          'icon': 'assets/icons/Calendly.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Call'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.red,
          'icon': 'assets/icons/Call.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Facetime'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.red,
          'icon': 'assets/icons/Facetime.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Googlemaps'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.red,
          'icon': 'assets/icons/Google Maps Location.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Googleplay'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.red,
          'icon': 'assets/icons/Google play.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Metamask'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.red,
          'icon': 'assets/icons/Metamask.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Opensea'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.red,
          'icon': 'assets/icons/Opensea.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Outlook'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.red,
          'icon': 'assets/icons/Outlook.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }
      if(key['Name']=='Website'){
        linkBlock.add({
          'title': key['Name'],
          'order': key['Order'],
          'color': Colors.red,
          'icon': 'assets/icons/Website.png',
          'isActive': key['isActive']==true ? 'Active': 'Inactive',
          'updatedTime': ((DateTime.now().microsecondsSinceEpoch-
              DateTime.parse(key['UpdatedTime']).microsecondsSinceEpoch)/(1000000*3600*24*7)).floor(),
          'function': () async{
            await launch(key['URL']);
          }
        });
      }

    });
    linkBlock.sort((var a, var b){
      return a['order']>b['order'] ? 1:-1;
    });
  }

  Widget profileImageWidget(){
    print(currentUser!.imgUrl);
    if(!isLoading){
      if(fileImage!=null){
        return Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60)
            ),
            child: Stack(
              children: [
                CircleAvatar(
                    radius: 60,
                    backgroundImage: FileImage(fileImage!)),
              ],
            ),
          ),
        );
      }else{
        return Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60)
            ),
            child: Stack(
              children: [
                CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/person.png') ),
              ],
            ),
          ),
        );
      }
    }else{
      return Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60)
          ),
          child: Stack(
            children: [
              CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/person.png') ),
            ],
          ),
        ),
      );
    }
  }

  openPreviewProfile(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> PreviewProfileView()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    UtilityCubit utilityCubit(bool renderUI) =>
        BlocProvider.of<UtilityCubit>(context, listen: renderUI);

    return Container(
      color: Color(0xffFBFBFB),
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     hSizedBox2,
              //     CustomLogo(),
              //     Spacer(),
              //     IconButton(
              //         onPressed: () {
              //           Navigator.of(context)
              //               .pushNamed(AppRouter.NotificationRoute);
              //         },
              //         icon: Icon(FontAwesomeIcons.solidBell)),
              //   ],
              // ),
              CustomTopBar(title: "",),
              Container(
               height: MediaQuery.of(context).size.height *0.23,
                child: Column(
                  children: [
                    firebaseUser!=null && fileImage==null && firebaseUser!.photoURL!=null ?  Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, AppRouter.PersonalDetailsRoute);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60)
                      ),
                      child: Stack(
                        children: [
                          CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(firebaseUser!.photoURL!)),
                        ],
                      ),
                    ),
                  ),
                ) : GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, AppRouter.PersonalDetailsRoute);
                      },
                        child: profileImageWidget()),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(name!=null ? name! : currentUser!.fullName!=null
                                ? currentUser!.fullName! : 'Full Name', textAlign: TextAlign.center,
                                style: KCustomTextstyle.kBold(context, 24)),
                          ),
                          Flexible(
                            child: Text(work!=null ? work! : "Occupation", textAlign: TextAlign.center,
                                style: KCustomTextstyle.kMedium(context, 14)),
                          ),
                          Flexible(
                            child: Text(loc!=null ? loc! : "Location", textAlign: TextAlign.center,
                                style: KCustomTextstyle.kMedium(context, 14)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              vSizedBox3,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      pushNewScreen(context,
                          screen: PersonalDetailsView(), withNavBar: false);
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      child: Center(
                          child: Text("Edit Profile",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: KConstantFonts.OpenSans,
                                  fontSize: 14,
                                  color: Color(0xff222222)))),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Color(0xffDDDDDD)),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  hSizedBox3,
                  GestureDetector(
                    onTap: () {
                      launch('http://caard.me/${currentUser!.userName}');
                     // openPreviewProfile();
                      print("username"+'http://caard.me/${currentUser!.userName}');
                      print("fullname"+'http://caard.me/${currentUser!.fullName}');
                      // pushNewScreen(context,
                      //     screen: PreviewProfileView(), withNavBar: false);
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      child: Center(
                          child: Text("Preview",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: KConstantFonts.OpenSans,
                                  fontSize: 14,
                                  color: Color(0xff222222)))),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Color(0xffDDDDDD)),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  )
                ],
              ),
              vSizedBox3,
              // Container(
              //     decoration: BoxDecoration(
              //         border: Border.all(
              //             width: 0.5, color: KConstantColors.bgColorFaint),
              //         borderRadius: BorderRadius.circular(8)),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         hSizedBox2,
              //         Container(
              //           width: 30.w,
              //           decoration: BoxDecoration(
              //               image: DecorationImage(
              //                   image:
              //                       AssetImage("assets/images/hand_card.png"))),
              //         ),
              //         hSizedBox3,
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //                 "Get a Personalised \nDigital Card to \nconnect with people",
              //                 style: KCustomTextstyle.kBold(context, 10)),
              //             vSizedBox2,
              //             Center(
              //               child: CustomButtons.roundedCorner(
              //                   title: "Order Now",
              //                   onTap: () async {
              //                     pushNewScreen(context, screen: StoreView());
              //                   },
              //                   width: 25,
              //                   height: 4,
              //                   textStyle:
              //                       KCustomTextstyle.kBoldWhite(context, 8),
              //                   context: context,
              //                   backgroundColor: KConstantColors.darkColor,
              //                   cornerRadius: 8),
              //             ),
              //           ],
              //         )
              //       ],
              //     ),
              //     height: 15.h),
              GestureDetector(
                onTap: (){
                  pushNewScreen(context, screen: StoreView());
                },
                child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.5, color: KConstantColors.bgColorFaint),
                          borderRadius: BorderRadius.circular(8)),
                      child: Image.asset('assets/images/caard-home-banner.png'),
                      height: 15.h),
                ),
              ),
              vSizedBox2,

//               ListTile(
//                 title: Row(
//                   children: [
//                     Text("Vehicle Mode",
//                         style: KCustomTextstyle.kBold(context, 12)),
//                     IconButton(
//                         onPressed: () {
//                           vechicleModeAlertDialog(context, "Vehicle Mode", """
// This mode allows you to select a
// distinguished platform of your choice
// which you think is the most relevant to
// your cause and showcase only that link """);
//                         },
//                         icon: Icon(Icons.info, size: 16)),
//                   ],
//                 ),
//                 trailing: Switch(
//                     activeColor: KConstantColors.whiteColor,
//                     activeTrackColor: KConstantColors.greenColor,
//                     value: utilityCubit(true).isVechicleMode ? true : false,
//                     onChanged: (val) {
//                       utilityCubit(false).setVechicleMode();
//                     }),
//               ),

              ListTile(
                title: Row(
                  children: [
                    Text("Direct Link",
                        style: KCustomTextstyle.kBold(context, 12)),
                    IconButton(
                        onPressed: () {
                          showDirectLinkAlertDialog(context, "Direct Link");
                        },
                        icon: Icon(Icons.info, size: 16))
                  ],
                ),
                trailing: directLinkActivated ? GestureDetector(
                  onTap: (){
                    if(directLinkActivated){
                      directLinkDeactivateApi(currentUser!.userId).then((user) {
                        CustomSnackBar.showSnackBar(color: Colors.green,
                            title: 'Direct Link De-Activated!!', context: context);
                        setState(() {
                          directLinkActivated= false;
                        });
                      });
                    }else{
                      directLinkActivateApi(currentUser!.userId).then((user){
                        CustomSnackBar.showSnackBar(color: Colors.green,
                            title: 'Direct Link Activated!!', context: context);
                        setState(() {
                          directLinkActivated= true;
                        });
                      });
                    }
                  },
                  child: Image.asset('assets/images/Toggle ON.png'),
                ) :
                  GestureDetector(
                    onTap: (){
                      if(directLinkActivated){
                        directLinkDeactivateApi(currentUser!.userId).then((user) {
                          CustomSnackBar.showSnackBar(color: Colors.green,
                              title: 'Direct Link De-Activated!!', context: context);
                          setState(() {
                            directLinkActivated= false;
                          });
                        });
                      }else{
                        directLinkActivateApi(currentUser!.userId).then((user){
                          CustomSnackBar.showSnackBar(color: Colors.green,
                              title: 'Direct Link Activated!!', context: context);
                          setState(() {
                            directLinkActivated= true;
                          });
                        });
                      }
                    },
                      child: Image.asset('assets/images/Toggle OFF.png')),
                // trailing: Switch(
                //     activeColor: KConstantColors.whiteColor,
                //     activeTrackColor: KConstantColors.greenColor,
                //     value: directLinkActivated,
                //     onChanged: (val) {
                //       // setState(() {
                //       //   utilityCubit(false).setDirectLinkActivated();
                //       // });
                //     }),
              ),
              ListTile(
                title: Row(
                  children: [
                    Text('Top Links', style: KCustomTextstyle.kBold(context, 12),),
                    SizedBox(width: 2,),
                    Icon(Icons.arrow_forward),
                    Spacer(),
                    TextButton(
                      onPressed: (){

                      },
                      child: Text('Edit Links', style: TextStyle(fontSize: 12, color: Colors.blue,
                        decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),)
                  ],
                ),
              ),
              vSizedBox2,
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (c, i){
                  return GestureDetector(
                    onTap: socialLinkBlock[i]['function'],
                    child: ListTile(
                      // leading: ,
                      title: Row(
                        children: [
                          Image.asset(
                            socialLinkBlock[i]['icon'],
                            // color: socialLinkBlock[i]['color'],
                          ),
                          SizedBox(width: 16,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(socialLinkBlock[i]['title'],
                                  style: TextStyle(
                                      color: Color(0xff222222),
                                      fontSize: 14, fontWeight: FontWeight.w600, fontFamily: KConstantFonts.OpenSans
                                  )),
                              SizedBox(height: 8,),
                              Text("Updated ${socialLinkBlock[i]['updatedTime'].toString()} weeks ago",
                                  style: TextStyle(
                                    color: Color(0xffA8A8A8),
                                    fontSize: 12, fontWeight: FontWeight.w400, fontFamily: KConstantFonts.OpenSans
                                  ))
                            ],
                          ),
                          Spacer(),
                          Text(
                            socialLinkBlock[i]['isActive'],
                            style: TextStyle(
                                fontFamily: KConstantFonts.OpenSans,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: socialLinkBlock[i]['isActive']=='Active'
                                    ? Color(0xff33DE24)
                                    : Color(0xffA8A8A8)),
                          ),
                        ],
                      ),
                      // subtitle: ,
                      // trailing: ,
                    ),
                  );
                },
                itemCount: socialLinkBlock.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(color: Color(
                    0xffE8E8E8
                  ),);
                },
              ),
              // ListTile(
              //   leading: Icon(
              //     FontAwesomeIcons.instagram,
              //     color: KConstantColors.redColor,
              //   ),
              //   title: Text("Instagram",
              //       style: KCustomTextstyle.kMedium(context, 10)),
              //   subtitle: Text("Added 12w ago",
              //       style: KCustomTextstyle.kMedium(context, 8)),
              //   trailing: Text(
              //     utilityCubit(true).activatedLinks.contains("Instagram")
              //         ? "Active"
              //         : "Inactive",
              //     style: TextStyle(
              //         fontFamily: KConstantFonts.OpenSans,
              //         fontSize: 10.sp,
              //         color: utilityCubit(true)
              //                 .activatedLinks
              //                 .contains("Instagram")
              //             ? KConstantColors.greenColor
              //             : KConstantColors.placeholderColor),
              //   ),
              // ),
              // ListTile(
              //   leading: Icon(
              //     FontAwesomeIcons.facebook,
              //     color: KConstantColors.blueColor,
              //   ),
              //   title: Text("Facebook",
              //       style: KCustomTextstyle.kMedium(context, 10)),
              //   subtitle: Text("Added 5d ago",
              //       style: KCustomTextstyle.kMedium(context, 8)),
              //   trailing: Text(
              //     utilityCubit(true).activatedLinks.contains("Facebook")
              //         ? "Active"
              //         : "Inactive",
              //     style: TextStyle(
              //         fontFamily: KConstantFonts.OpenSans,
              //         fontSize: 10.sp,
              //         color:
              //             utilityCubit(true).activatedLinks.contains("Facebook")
              //                 ? KConstantColors.greenColor
              //                 : KConstantColors.placeholderColor),
              //   ),
              // ),
              // ListTile(
              //   leading: Icon(
              //     FontAwesomeIcons.twitter,
              //     color: KConstantColors.blueColor,
              //   ),
              //   title: Text("Twitter",
              //       style: KCustomTextstyle.kMedium(context, 10)),
              //   subtitle: Text("Added few seconds ago",
              //       style: KCustomTextstyle.kMedium(context, 8)),
              //   trailing: Text(
              //     utilityCubit(true).activatedLinks.contains("Twitter")
              //         ? "Active"
              //         : "Inactive",
              //     style: TextStyle(
              //         fontFamily: KConstantFonts.OpenSans,
              //         fontSize: 10.sp,
              //         color:
              //             utilityCubit(true).activatedLinks.contains("Twitter")
              //                 ? KConstantColors.greenColor
              //                 : KConstantColors.placeholderColor),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
