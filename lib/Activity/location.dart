import 'package:flutter/material.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade800, Colors.blue.shade300])),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(searchController.text == "") {
                          print("Blank search");
                        }else {
                          Navigator.pushNamed(context, "/loading", arguments: {
                            "searchText": searchController.text,
                          });
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.fromLTRB(2, 0, 5, 0),
                          child: Icon(
                            Icons.search,
                            color: Colors.blue,
                          )),
                    ),
                    Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search any city"),
                        ))
                  ],
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 180,
                      padding: EdgeInsets.all(28),
                      margin:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(14)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("No Data Found",style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.normal
                          ),),

                        ],
                      )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
