import 'package:flutter/material.dart';
import 'package:flutter_app_sqlite1/provider/sanpham_provider.dart';


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

  @override
  void didChangeDependencies() {
    if(widget.sanPhamMode == SanPhamMode.Editing){_titleController.text = widget.sanpham['title'];
    _textController.text =  widget.sanpham['text'];}
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    final title = _titleController.text;
                    final text = _textController.text;
                    if (widget?.sanPhamMode == SanPhamMode.Adding){
                      SanphamProvider.insertSanpham({
                        'title' : title,
                        'text': text,
                      });
                    }else if(widget?.sanPhamMode == SanPhamMode.Editing){
                      SanphamProvider.updateSanpham({
                        'id' : widget.sanpham['id'],
                        'title' : title,
                        'text': text,
                      });
                    }
                    Navigator.pop(context);
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