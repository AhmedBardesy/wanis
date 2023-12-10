import 'package:flutter/material.dart';
import 'package:humanitarian_icons/humanitarian_icons.dart';

import '../services/current_location.dart';
import '../services/map.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var controler = TextEditingController();
  String currLoc = "";
  var details = [];
  String date_time = "", address = "";
  var loc = [];
  String hospitalName = "";
  @override
  void initState() {
    currentLoc();
  }

  @override
  Widget build(BuildContext context) {
    currentLoc();

    try {
      loc[0];
    } catch (e) {
      currentLoc();
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xffEBDCCD),
      appBar: AppBar(
        backgroundColor: const Color(0xffEBDCCD),
        elevation: 0,
        actions: [
          Center(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/thelogo.jpg')))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Center(
                child: Text('Wanis',
                    style: Theme.of(context).textTheme.headline2)),
            const SizedBox(
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.all(15),
              child: SearchInputFb1(
                  searchController: null, hintText: 'what you looking for '),
            ),
            GradientButtonFb1(
              color: Color(0xffca7c6c),
              text: 'Search',
              onPressed: () {},
            ),
            const SizedBox(
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {
                      MapUtils.openMap();
                      // MapUtils.openMap(
                      //     double.parse(loc[0]), double.parse(loc[1]));
                    },
                    icon: const Icon(
                      Icons.emergency_outlined,
                      color: Colors.black,
                    ),
                    label:  Text(
                      'Hospital'
                      ,style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  ElevatedButton.icon(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {
                      MapUtils.openMappharmacy(
                          double.parse(loc[0]), double.parse(loc[1]));
                    },
                    icon: const Icon(
                      HumanitarianIcons.medical_supply,
                      color: Colors.black,
                    ),
                    label:  Text('Pharmacy'
                       ,style: Theme.of(context).textTheme.headline1,),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  void currentLoc() async {
    currLoc = await getLoc();
    date_time = currLoc.split("{}")[0];
    address = currLoc.split("{}")[2];
    loc = currLoc.split("{}")[1].split(" , ");
  }
}

class GradientButtonFb1 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color;
  const GradientButtonFb1(
      {required this.text,
      required this.onPressed,
      Key? key,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff4338CA);
    const secondaryColor = Color(0xff6D28D9);
    const accentColor = Color(0xffffffff);

    const double borderRadius = 15;

    return DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient:
                const LinearGradient(colors: [primaryColor, secondaryColor])),
        child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              alignment: Alignment.center,
              padding: MaterialStateProperty.all(const EdgeInsets.only(
                  right: 35, left: 35, top: 15, bottom: 15)),
              backgroundColor: MaterialStateProperty.all(color),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius)),
              )),
          onPressed: onPressed,
          child: Text(
            text
            ,style: Theme.of(context).textTheme.headline1,
            
          ),
        ));
  }
}

class SearchInputFb1 extends StatelessWidget {
  final TextEditingController? searchController;
  final String hintText;

  const SearchInputFb1(
      {required this.searchController, required this.hintText, Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextField(
        controller: searchController,
        textAlign: TextAlign.center,
        onChanged: (value) {},
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.email),
          prefixIcon:
              const Icon(Icons.search, size: 20, color: Color(0xffFF5A60)),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle:  Theme.of(context).textTheme.headline3,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
      ),
    );
  }
}
