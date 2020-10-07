import 'package:flutter/material.dart';
import 'package:flutter_app_sqlite1/provider/sanpham_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';


enum SanPhamMode{
  Editing,
  Adding
}
class SanPham extends StatefulWidget{
  final SanPhamMode sanPhamMode;
  final Map<String,dynamic> sanpham;

  const SanPham(this.sanPhamMode, this.sanpham);

  @override
  _SanPhamState createState() => _SanPhamState();
}

class _SanPhamState extends State<SanPham> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  @override
  void didChangeDependencies() {
    if(widget.sanPhamMode == SanPhamMode.Editing){_titleController.text = widget.sanpham['title'];
    _textController.text =  widget.sanpham['text'];
    _imageController.text =  widget.sanpham['image'];}
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.sanPhamMode == SanPhamMode.Adding ? "Thêm Sản phẩm" : "Sửa sản phẩm"),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Tiêu đề",
              ),
            ),
            Padding(padding: EdgeInsets.all(20.0)),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: "Nội dung",
              ),
            ),
            Padding(padding: EdgeInsets.all(20.0)),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(
                hintText: "Địa chỉ hình ảnh",
              ),
            ),
            Padding(padding: EdgeInsets.all(20.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    final title = _titleController.text;
                    final text = _textController.text;
                    final image = _imageController.text;
                    if (widget?.sanPhamMode == SanPhamMode.Adding){
                      if(title.length>0 && text.length>0 && image.length>0){
                        Fluttertoast.showToast(
                            msg: "Thêm dữ liệu thành công",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.lightGreenAccent,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        SanphamProvider.insertSanpham({
                          'title' : title,
                          'text': text,
                          'image': image,
                        });
                        Navigator.pop(context);}else
                      {
                        Fluttertoast.showToast(
                            msg: "Vui lòng điền đầy đủ dữ liệu",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        Navigator.canPop(context);
                      }
                    }else if(widget?.sanPhamMode == SanPhamMode.Editing){
                      if(title.length>0 && text.length>0 && image.length>0 ){
                        Fluttertoast.showToast(
                            msg: "Sửa dữ liệu thành công",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.lightGreenAccent,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        SanphamProvider.updateSanpham({
                          'id' : widget.sanpham['id'],
                          'title' : title,
                          'text': text,
                          'image': image,
                        });
                        Navigator.pop(context);
                      }else{
                        Fluttertoast.showToast(
                            msg: "Vui lòng điền đầy đủ dữ liệu",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        Navigator.canPop(context);
                      }

                    }

                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 100.0,
                    height: 40.0,
                    color: Colors.blue,
                    child: Text("LƯU"),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    alignment: Alignment.center,
                    width: 100.0,
                    height: 40.0,
                    color: Colors.grey,
                    child: Text("Làm lại"),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                widget.sanPhamMode == SanPhamMode.Editing ?
                GestureDetector(
                  onTap: (){
                    SanphamProvider.deleteSanpham(
                      widget.sanpham['id'],
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 100.0,
                    height: 40.0,
                    color: Colors.red,
                    child: Text("Xóa"),
                  ),
                ): Container()
              ],
            )
          ],
        ),
      ),
    );
  }
}