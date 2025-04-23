import 'dart:core';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:untitled3/helper/type_helper.dart';
import 'package:untitled3/model/file_model.dart';
import 'package:untitled3/servise/file_service.dart';
import 'package:untitled3/widget/search_icon.dart';

class FileExplorerPage extends StatefulWidget with TypeHelper{
  final String path;

  const FileExplorerPage({Key? key, required this.path}) : super(key: key);

  @override
  _FileExplorerPageState createState() => _FileExplorerPageState();

}

class _FileExplorerPageState extends State<FileExplorerPage> {
  late List<FileSystemEntity> files;
  List<FileSystemEntity> filteredFiles = [];
late FileUploadModel fileModel;
  TextEditingController searchController = TextEditingController();
  final List<String> chipLabels = ["ListView", "GridView"];
  String selectedLabel = 'ListView';
  bool isActive = false;

@override
  void initState() {
    super.initState();
    loadFiles();
  }

  void loadFiles() {
    try {
      final directory = Directory(widget.path);
      files = directory.listSync();
      filterFiles(searchController.text);
    } catch (e) {
      files = [];
      filteredFiles = [];
      print('Error loading files: $e');
    }
  }
void filterFiles (String query){
  if(query.isEmpty){
    filteredFiles = files;
  }else{
    filteredFiles = files.where((f){
      final name = f.path.split(Platform.pathSeparator).last.toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();
  }
  setState(() {

  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFBFBFB),
      appBar: AppBar(
        backgroundColor: Color(0xffFBFBFB),
          title: Text(
            widget.path,
          ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: Search(
              onSearchChanged: (query) {
                filterFiles(query);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildChips(),
          Expanded(
            child: selectedLabel == "ListView"
           ? ListView.builder(
              itemCount: filteredFiles.length,
              itemBuilder: (context, index) {
                final file = filteredFiles[index];
                return _buildFileItemListView(file);
              },
            )
           : Padding(
             padding: const EdgeInsets.all(32.0),
             child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 220,
                  ),
                  itemCount:filteredFiles.length,
                  itemBuilder: (context,index){
                    final file = filteredFiles[index];
                    return _buildFileItemGridView(file);
                  }
              ),
           )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewItemDialog,
        backgroundColor: Color(0xff8459FE),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }

  void _createNewItemDialog() {
    String name = '';
    String type = 'file';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create New'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (val) => name = val,
              ),
              DropdownButton<String>(
                value: type,
                items: [
                  DropdownMenuItem(value: 'file', child: Text('File')),
                  DropdownMenuItem(value: 'folder', child: Text('Folder')),
                ],
                onChanged: (val) {
                  setState(() {
                    type = val!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  final newPath = '${widget.path}\\$name';
                  if (type == 'folder') {
                    Directory(newPath).createSync();
                  } else {
                    File(newPath).createSync();
                  }
                  Navigator.pop(context);
                  loadFiles();
                  setState(() {});
                },
                child: Text('Create')),
          ],
        );
      },
    );
  }

  Widget _buildChips(){
  return Padding(padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 32),
    child: Row(
      children: chipLabels.map((label) {
        final bool isSelected = selectedLabel == label;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: FilterChip(
              label: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              selected: isSelected,
              onSelected: (_) {
                setState(() {
                  selectedLabel = label;
                });
              },
              selectedColor: Color(0xff8459FE),
              backgroundColor: Colors.grey.shade300,
              checkmarkColor: Colors.transparent,
              showCheckmark: false,
              shape: StadiumBorder(
                side: BorderSide(
                    color: isSelected
                        ? Color(0xff8459FE)
                        : Color(0xffD7D7D7)
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10,),
            ),
          ),
        );
      }).toList(),
    ),
  );
  }

  Widget _buildFileItemListView(FileSystemEntity file){
  final isDir = FileSystemEntity.isDirectorySync(file.path);
  final fileName = file.path.split(Platform.pathSeparator).last;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 32),
    child: Container(
      width: 311,
      height: 100,
      decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color(0xffF1F1F1),
              offset: Offset(3, 3),
              blurRadius: 5,
              spreadRadius: 4,
            ),
          ]
      ),
      child: GestureDetector(
        onTap: () {
          if (isDir) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FileExplorerPage(path: file.path),
              ),
            );
          }
        },
        child: Row(
          children: [
            FileThumbnail(file: file, isDirectory: isDir),
            //Image.asset(isDir ? "assets/icons/dir.png" : getFileTypeIcon(file.path), width: 80, height: 80,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 10),
                    child: Text(fileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        style:TextStyle (
                          color: Colors.grey,
                        ),() {
                      try {
                        if (isDir) {
                          final count = Directory(file.path).listSync().length;
                          final stat = File(file.path).statSync();
                          final sizeKB = (stat.size / 1024).toStringAsFixed(2);
                          final modified = stat.modified;
                          return '$count item\n$sizeKB KB - ${modified.toString().split(".")[0]}';
                        } else {
                          final stat = File(file.path).statSync();
                          final sizeKB = (stat.size / 1024).toStringAsFixed(2);
                          final modified = stat.modified;
                          return '$sizeKB KB - ${modified.toString().split(".")[0]}';
                        }
                      } catch (e) {
                        return "unknown";
                      }
                    }()),
                  ),

                ],
              ),
            ),
            if(!isDir)
              InkWell(
                  onTap: ()async{
                    setState(() {
                      isActive = true;
                    });
                    bool status = await FileUploadService().uploadFile(
                      model: FileUploadModel(file: File(file.path)),

                    );
                    if(status){
                      setState(() {
                        isActive = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Uploading Successfully"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      setState(() {
                        isActive = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Failed to upload"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Visibility(
                        visible: !isActive,
                        replacement: CircularProgressIndicator(),
                        child: Icon(Icons.cloud_upload_outlined)),
                  )),
          ],
        ),
      ),
    ),
  );
  }
  Widget _buildFileItemGridView(FileSystemEntity file){
    final isDir = FileSystemEntity.isDirectorySync(file.path);
    final fileName = file.path.split(Platform.pathSeparator).last;
    return Container(
      width: 311,
      height: 100,
      decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color(0xffF1F1F1),
              offset: Offset(3, 3),
              blurRadius: 5,
              spreadRadius: 4,
            ),
          ]
      ),
      child: GestureDetector(
        onTap: () {
          if (isDir) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FileExplorerPage(path: file.path),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FileThumbnail(file: file, isDirectory: isDir),
              Text(
                fileName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                  style:TextStyle (
                    color: Colors.grey,
                  ),() {
                try {
                  if (isDir) {
                    final count = Directory(file.path).listSync().length;
                    final stat = File(file.path).statSync();
                    final sizeKB = (stat.size / 1024).toStringAsFixed(2);
                    final modified = stat.modified;
                    return '$count item\n$sizeKB KB | ${modified.toString().split(".")[0]}';
                  } else {
                    final stat = File(file.path).statSync();
                    final sizeKB = (stat.size / 1024).toStringAsFixed(2);
                    final modified = stat.modified;
                    return '$sizeKB KB - ${modified.toString().split(".")[0]}';
                  }
                } catch (e) {
                  return "unknown";
                }
              }()),
              if(!isDir)
                InkWell(
                    onTap: ()async{
                      setState(() {
                        isActive = true;
                      });
                      bool status = await FileUploadService().uploadFile(
                        model: FileUploadModel(file: File(file.path)),

                      );
                      if(status){
                        setState(() {
                          isActive = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Uploading Successfully"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        setState(() {
                          isActive = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Failed to upload"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Visibility(
                          visible: !isActive,
                          replacement: CircularProgressIndicator(),
                          child: Icon(Icons.cloud_upload_outlined)),
                    ),
                ),
            ],
          ),
        ),
      ),
    );
  }

}

class FileThumbnail extends StatelessWidget {
  final FileSystemEntity file;
  final bool isDirectory;

  const FileThumbnail({
    super.key,
    required this.file,
    required this.isDirectory,
  });

  @override
  Widget build(BuildContext context) {
    if (isDirectory) {
      return Image.asset(
        "assets/icons/dir.png",
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      );
    }

    if (isImage(file.path)) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(file.path),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _defaultIcon(file.path),
          ),
        ),
      );
    }

    return _defaultIcon(file.path);
  }

  Widget _defaultIcon(String path) {
    return Image.asset(
      getFileTypeIcon(path),
      width: 80,
      height: 80,
      fit: BoxFit.cover,
    );
  }

  bool isImage(String path) {
    final ext = path.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(ext);
  }

  String getFileTypeIcon(String path) {
    final extension = path.split('.').last.toLowerCase();
    if (['mp4', 'avi', 'mov'].contains(extension)) {
      return 'assets/icons/video.png';
    } else if (['mp3', 'wav'].contains(extension)) {
      return 'assets/icons/music.png';
    } else if (['pdf'].contains(extension)) {
      return 'assets/icons/img.png';
    } else if (['doc', 'docx', 'txt'].contains(extension)) {
      return 'assets/icons/Document.png';
    } else {
      return 'assets/icons/Document.png';
    }
  }
}
