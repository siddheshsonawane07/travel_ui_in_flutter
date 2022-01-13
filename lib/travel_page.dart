import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({Key? key}) : super(key: key);

  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  final urlimage =
      "https://scontent.fpnq11-1.fna.fbcdn.net/v/t1.6435-9/133124927_212730653814076_4734987525881512022_n.jpg?_nc_cat=100&ccb=1-5&_nc_sid=174925&_nc_ohc=uyY65QApa1gAX_-XeWn&_nc_ht=scontent.fpnq11-1.fna&oh=00_AT9ftw5a7-CwGYhBNsrFLTjMzcgykVISx1gFi7PoDoa3fA&oe=62029F83";
  final pic1 =
      "https://akm-img-a-in.tosshub.com/indiatoday/images/story/201812/Historical_Gateway_Of_India-647x363.jpeg?iGR4dZKU22tmOaehpPjg0alkOeHE72sE&size=1200:675";

  final pic2 =
      "https://res.cloudinary.com/thrillophilia/image/upload/c_fill,f_auto,fl_progressive.strip_profile,g_auto,q_auto/v1/filestore/480xyutg27yqds55oev43kmcu67p_image.jpg";

  TabController? _tabController;

  double anim = 1.0;

  double anim2 = 1.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    withAnimation(
        vsync: this,
        tween: Tween(begin: 1.0, end: 0.0),
        callBack: (double? animationVal, controllerVal) {
          anim = animationVal!;
          setState(() {});
        });

    withRepeatAnimation(
        vsync: this,
        isRepeatReversed: true,
        tween: Tween(begin: 2.0, end: 3.0),
        callBack: (double? animationVal, controllerVal) {
          anim2 = animationVal!;
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    final tabIndex = _tabController?.index;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Vx.purple500,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: VStack([
            VxBox().size(20, 2).white.make(),
            5.heightBox,
            VxBox().size(28, 2).white.make(),
            5.heightBox,
            VxBox().size(15, 2).white.make(),
            5.heightBox,
          ]).pOnly(left: 16, top: 16)),
      body: VStack([
        VxBox(
                child: [
          VxBox()
              .square(100)
              .roundedFull
              .neumorphic(color: Vx.purple500, elevation: 30.0)
              .bgImage(DecorationImage(image: NetworkImage(urlimage)))
              .make(),
          "Hi, "
              .richText
              .withTextSpanChildren(["Siddhesh".textSpan.white.bold.make()])
              .white
              .xl2
              .make()
              .p8()
              .offset(offset: Offset(-300 * anim, 0)),
          "Solo Traveller".text.white.make(),
          SizedBox(height: size.height * 0.01),
          SingleChildScrollView(
            child: VxTextField(
                    borderType: VxTextFieldBorderType.none,
                    borderRadius: 18,
                    hint: "Search",
                    fillColor: Vx.gray200.withOpacity(0.4),
                    contentPaddingTop: 13,
                    autofocus: false,
                    prefixIcon: const Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                    ))
                .customTheme(themeData: ThemeData(brightness: Brightness.dark))
                .cornerRadius(40)
                .p16(),
          )
        ].column())
            .makeCentered()
            .h32(context),
        20.heightBox,
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Expanded(
            child: VxBox(
                child: VStack([
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.purple,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Vx.purple500,
                unselectedLabelColor: Vx.gray400,
                labelPadding: Vx.m16,
                tabs: [
                  const Icon(Icons.map, size: 10)
                      .scale(scaleValue: tabIndex == 0 ? anim2 : 3.00),
                  const Icon(Icons.pin_drop, size: 10)
                      .scale(scaleValue: tabIndex == 1 ? anim2 : 3.00),
                  const Icon(Icons.restaurant, size: 10)
                      .scale(scaleValue: tabIndex == 2 ? anim2 : 3.00),
                  const Icon(Icons.person, size: 10)
                      .scale(scaleValue: tabIndex == 3 ? anim2 : 3.00),
                ],
              ).h(context.percentHeight * 8),
              Expanded(
                child: TabBarView(
                    controller: _tabController,
                    children: ["1", "2", "3", "4"]
                        .map((e) => VStack([
                              "Discover Places in India"
                                  .text
                                  .gray600
                                  .xl2
                                  .bold
                                  .make(),
                              40.heightBox,
                              TravelCard(
                                  imageUrl: pic1,
                                  subtitle: "Mumbai",
                                  title: "Gateway of India"),
                              10.heightBox,
                              TravelCard(
                                  imageUrl: pic2,
                                  subtitle: "Pune",
                                  title: "Shaniwar Wada")
                            ]).p16())
                        .toList()),
              )
            ])).white.make(),
          ),
        ).expand()
      ]),
    );
  }
}

class TravelCard extends StatelessWidget {
  const TravelCard({
    Key? key,
    required this.imageUrl,
    required this.subtitle,
    required this.title,
  }) : super(key: key);

  final String title, subtitle, imageUrl;

  @override
  Widget build(BuildContext context) {
    return HStack([
      Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ).wh(context.percentWidth * 35, 100).cornerRadius(10),
      20.widthBox,
      Expanded(
        child: VStack(
          [
            title.text.xl2.make(),
            3.heightBox,
            subtitle.text.make().shimmer(),
            5.heightBox,
            [
              VxRating(onRatingUpdate: (value) {}),
              5.widthBox,
              "(1000)".text.xs.gray600.make(),
            ].row(),
          ],
          crossAlignment: CrossAxisAlignment.start,
        ),
      )
    ]).cornerRadius(8).backgroundColor(Vx.gray200);
  }
}
