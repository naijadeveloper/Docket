// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final Uri _urlLinkedin = Uri.parse('https://linkedin.com/in/enoch-enujiugha-b12247112');

  final Uri _urlPortfolio = Uri.parse('https://naijadev.vercel.app/');

  final Uri _urlbmc = Uri.parse('https://www.buymeacoffee.com/mmejuenoch');
  
  var border = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About app",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Docket",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    child: Text("By the fantastic Enoch E",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          launchUrl(_urlLinkedin);
                        },
                        child: Image.asset("assets/icons/linkedin.png", 
                          width: 60,
                          height: 60,
                        ),
                      ),

                      SizedBox(width: 8.0),

                      GestureDetector(
                        onTap: () {
                          launchUrl(_urlPortfolio);
                        },
                        child: Image.asset("assets/icons/portfolio.png",
                          width: 60,
                          height: 60,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Text("Support me below, so that I can buy better tech gadgets and build better apps",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ]
              ),
          
              Container(
                alignment: Alignment(0.0, border? 0.6 : 0.61),
                child: GestureDetector(
                  onTapDown: (TapDownDetails dets) {
                    setState(() {
                      border = false;
                    });
                  },
                  onTapUp: (TapUpDetails dets) {
                    setState(() {
                      border = true;
                    });
                    launchUrl(_urlbmc);
                  },
                  onTapCancel: () {
                    setState(() {
                      border = true;
                    });
                  },
                  child: Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                        color: Colors.orange[500],
                        border: Border(
                          top: BorderSide(
                            width: 0.5,
                            color: Colors.orange[800]!,
                          ),
                                
                          bottom: BorderSide(
                            width: border? 5.0 : 0.5,
                            color: Colors.orange[800]!,
                          ),
                                
                          left: BorderSide(
                            width: border? 2.0 : 0.5,
                            color: Colors.orange[800]!,
                          ),
                                
                          right: BorderSide(
                            width: 0.5,
                            color: Colors.orange[800]!,
                          ),
                        ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/icons/bmc.png",
                          width: 50,
                          height: 50,
                        ),
                        Text("Buy me a coffee",
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "GochiHand"
                          ),
                        )
                      ]
                    ),
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