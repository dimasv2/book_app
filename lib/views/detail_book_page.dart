//import 'dart:async';
import 'dart:convert';

import 'package:book/controllers/book.controller.dart';
import 'package:book/models/book_detail_response.dart';
import 'package:book/models/book_list_response.dart';
import 'package:book/views/image_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailBookPage extends StatefulWidget {
  const DetailBookPage({Key? key, required this.isbn}) : super(key: key);
final String isbn;
  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  BookController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Provider.of<BookController>(context, listen: false);
    controller!.fetchDetailBookApi(widget.isbn);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Detail"),
        ),
        body: Consumer<BookController>(builder: (context, controller, child) {
            return controller.detailBook == null?
            Center(child: CircularProgressIndicator()):
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageViewScreen(
                          imageUrl: controller.detailBook!.image!,
                          ),
                          ),
                          );
                      },
                      child: Image.network(controller.detailBook!.image!,
                      height: 150,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 9.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.detailBook!.title!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                             Text(controller.detailBook!.authors!,
                             style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              //fontWeight: FontWeight.bold,
                            ),
                            ),
                            SizedBox(height: 10),
                         
                             Row(
                              children: List.generate(
                                5,
                               (index) => Icon(Icons.star,
                              color: index < int.parse(controller.detailBook!.rating!) ? Colors.yellow : Colors.grey, 
                              ),
                              ),
                              ),
                            Text(controller.detailBook!.subtitle!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                            Text(controller.detailBook!.price!,
                             style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                 Divider(),
                SizedBox(height: 20),
                 Container(
                  width: double.infinity,
                   child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //fixedSize: Size(double.infinity, 50)
                    ),
                    onPressed: () async{
                      print("url");
                      Uri uri = Uri.parse(controller.detailBook!.url!);
                      try {
                       (await canLaunchUrl(uri)) ? launchUrl(uri) : print ("tidak berhasil navigasi");
                      } catch (e) {
                        print("error");
                        print(e);
                        
                      }
                      
                     },
                  
                     child: Text("BUY")),
                 ),
                 SizedBox(height: 20),
                 Text(controller.detailBook!.desc!),
                 SizedBox(height: 20),
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     
                
                Text("ISBN " + controller.detailBook!.isbn13!),
                 Text(controller.detailBook!.pages! + " Page"),
                 Text("Language: " + controller.detailBook!.language!),
                 Text("Publisher: " + controller.detailBook!.publisher!),
                 Text("Year: " + controller.detailBook!.year!),
                 
                   ],
                 ),
                 Divider(),
                 controller.similiarBooks == null ? CircularProgressIndicator()
                 : Expanded(
                   child: Container(
                    height: 180,
                     child: ListView.builder(
                     // shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.similiarBooks!.books!.length,
                      //physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        final current = controller.similiarBooks!.books![index];
                        return Container(
                          width: 100,
                          child: Column(children: [
                            Image.network(current.image!,
                            height: 100,
                            ),
                            Text(current.title!,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            )
                          ]),
                        );
                      }
                     ),
                   ),
                 )
                 
               
              ],
              ),
            );
          }
        ),
    );
    
  }
}