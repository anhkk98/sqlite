import 'package:flutter/material.dart';
import 'package:flutter_app_sqlite1/provider/sanpham_provider.dart';

import 'package:flutter_app_sqlite1/views/sanpham.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListSp extends StatefulWidget{

  @override
  _ListSpState createState() => _ListSpState();
}

class _ListSpState extends State<ListSp> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purple[50],Colors.purple[200],Colors.purple[400]],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft
            )
        ),
        child: FutureBuilder(future: SanphamProvider.getSanphamList(),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.done){
              final sanpham = snapshot.data;
              return ListView.builder(
                  itemCount: sanpham.length,
                  itemBuilder: (context,index){
                    return Container(

                      child: Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        secondaryActions: <Widget>[

                          IconSlideAction(

                            caption: 'Sửa',
                            color: Colors.black45,
                            icon: Icons.edit,
                            onTap: () async{
                              await Navigator.push(context, MaterialPageRoute(builder: (context) => SanPham(SanPhamMode.Editing,sanpham[index])));
                              setState(() {

                              });
                            },
                          ),
                          IconSlideAction(
                            caption: 'Xóa',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: (){
                              setState(() {
                                SanphamProvider.deleteSanpham(
                                  sanpham[index]['id'],
                                );
                              });

                            },
                          ),
                        ],
                        key: ObjectKey(snapshot),

                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 120.0,
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),color: Colors.grey[300]
                            ),

                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 6.0),
                                  child: Container(
                                    width: 120.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        image: DecorationImage(image: NetworkImage(sanpham[index]['image'],),fit: BoxFit.fill)
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(sanpham[index]['title'],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700),),
                                      Padding(padding: EdgeInsets.all(5.0)),
                                      Text(sanpham[index]['text'],maxLines: 2,overflow: TextOverflow.ellipsis,)
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),

                    );
                  });

            }
            return Center(child: CircularProgressIndicator(),);

          },),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{
        await Navigator.push(context, MaterialPageRoute(builder: (context) => SanPham(SanPhamMode.Adding,null)));
        setState(() {

        });
      },child: Icon(Icons.add),),

    );
  }
}