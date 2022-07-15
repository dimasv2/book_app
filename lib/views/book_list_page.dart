
import 'package:book/controllers/book.controller.dart';
import 'package:book/views/detail_book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
 BookController? bookController;
 bool isSearching = false;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookController = Provider.of<BookController>(context, listen: false);
    bookController!.fetchBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
      leading: IconButton(
       icon: SvgPicture.asset("assets/icons/back.svg", color: Colors.white,), onPressed: (){},
       ),
       actions: <Widget>[
        IconButton(
           icon: SvgPicture.asset("assets/icons/search.svg", color: Colors.white), onPressed: (){
            setState(() {
              this.isSearching = !this.isSearching;
            });
           },
           ),
          IconButton(
           icon: SvgPicture.asset("assets/icons/cart.svg", color: Colors.white), onPressed: (){},
           ),
       ],
        title: !isSearching ? Text('Book Catalogue'): TextField(decoration: InputDecoration(
          icon: Icon(Icons.search),
          hintText: "Search Book Here", 
          ),
          ),
      ),
      body:  Consumer<BookController>(
        child: const Center(child: CircularProgressIndicator()),
        builder: (context, controller, child)=> Container(
        child:  bookController!. bookList == null ?
           child:
          
           ListView.builder(
            itemCount:bookController!.bookList!.books!.length,
            itemBuilder: (context, index) {
              final currentBook = bookController!.bookList!.books![index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailBookPage(isbn:currentBook.isbn13!
                  ),
                  ),
                  );
                },
                child: Row(
                  children: [
                  Image.network(currentBook.image!,
                  height: 100,
                  ),
                  Expanded(
                    
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(currentBook.title!),
                          Text(currentBook.subtitle!),
                          Align (
                            alignment: Alignment.topRight,
                            child: Text(currentBook.price!)),
                          ],
                          ),
                    ),
                  ),
                      ]
                  ),
              );
            
          })),
      ),
      );
  }
}