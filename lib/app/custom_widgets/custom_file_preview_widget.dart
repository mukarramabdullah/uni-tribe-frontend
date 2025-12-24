// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io';
// import 'dart:convert';
// import 'package:uni_tribe/app/config/app_colors.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:draftflow_io/app/config/app_utils.dart';
// import 'dart:typed_data';

// class FilePreviewScreen extends StatefulWidget {
//   final String fileTitle;
//   final String? documentId;
//   final String fileExtension;
//   final String? localFilePath; // For files picked locally
//   final File? file; // Direct file object
//   final String? fileUrl; // URL from server

//   const FilePreviewScreen({
//     Key? key,
//     required this.fileTitle,
//     this.documentId,
//     required this.fileExtension,
//     this.localFilePath,
//     this.file,
//     this.fileUrl, // ADD THIS
//   }) : super(key: key);

//   @override
//   State<FilePreviewScreen> createState() => _FilePreviewScreenState();
// }

// class _FilePreviewScreenState extends State<FilePreviewScreen> {
//   String? localFilePath;
//   String? textContent;
//   bool isLoading = true;
//   String? errorMessage;
//   int currentPage = 0;
//   int totalPages = 0;
//   File? _fileToPreview;

//   @override
//   void initState() {
//     super.initState();
//     _initializePreview();
//   }

//   Future<void> _initializePreview() async {
//     try {
//       // Check if file was passed directly
//       if (widget.file != null) {
//         _fileToPreview = widget.file;
//         await _loadFileContent(_fileToPreview!);
//         return;
//       }

//       // Check if local file path was passed
//       if (widget.localFilePath != null) {
//         _fileToPreview = File(widget.localFilePath!);
//         if (await _fileToPreview!.exists()) {
//           await _loadFileContent(_fileToPreview!);
//           return;
//         }
//       }

//       // If no local file but we have a URL, try to download it
//       if (widget.fileUrl != null && widget.fileUrl!.isNotEmpty) {
//         await _downloadFileFromUrl(widget.fileUrl!);
//         return;
//       }

//       // If no local file and no URL, show UI to let user pick the file manually
//       setState(() {
//         isLoading = false;
//         errorMessage = 'notAvailable'; // Special flag for manual download UI
//       });
//     } catch (e) {
//       print('❌ Error initializing preview: $e');
//       setState(() {
//         isLoading = false;
//         errorMessage = e.toString();
//       });
//     }
//   }

//   Future<void> _downloadFileFromUrl(String url) async {
//     try {
//       print('📥 Downloading file from URL: $url');
//       print('🔑 Document ID: ${widget.documentId}');

//       // Try direct URL first (for public URLs like DigitalOcean Spaces)
//       http.Response response;

//       try {
//         print('🔄 Attempting direct download from URL...');
//         response = await http
//             .get(
//               Uri.parse(url),
//               headers: {'Accept': '*/*', 'User-Agent': 'DraftFlow-Mobile-App'},
//             )
//             .timeout(
//               const Duration(seconds: 30),
//               onTimeout: () => throw Exception('Download timed out'),
//             );

//         print('📡 Direct download response: ${response.statusCode}');
//       } catch (e) {
//         print('⚠️ Direct download failed: $e');

//         // If direct download fails and we have documentId, try via API
//         if (widget.documentId != null && widget.documentId!.isNotEmpty) {
//           print('🔄 Attempting download via API...');
//           response = await _downloadViaAPI(widget.documentId!);
//         } else {
//           rethrow;
//         }
//       }

//       if (response.statusCode == 200) {
//         print('✅ File downloaded: ${response.bodyBytes.length} bytes');
//         print('📋 Content-Type: ${response.headers['content-type']}');

//         // Get temporary directory
//         final tempDir = await getTemporaryDirectory();
//         final sanitizedTitle = widget.fileTitle
//             .replaceAll(RegExp(r'[^\w\s-]'), '_')
//             .replaceAll(RegExp(r'\s+'), '_');
//         // Ensure extension is lowercase and properly set
//         final cleanExtension = widget.fileExtension.toLowerCase().trim();
//         final filePath = '${tempDir.path}/$sanitizedTitle.$cleanExtension';

//         print('🔍 File extension from widget: ${widget.fileExtension}');
//         print('🔍 Clean extension: $cleanExtension');
//         print('💾 Full file path: $filePath');

//         print('💾 Saving file to: $filePath');

//         // Save file AS BINARY - DO NOT decode
//         final file = File(filePath);
//         await file.writeAsBytes(response.bodyBytes);

//         // Verify the file was saved correctly
//         final savedSize = await file.length();
//         print('✅ File saved: $savedSize bytes');

//         if (savedSize != response.bodyBytes.length) {
//           throw Exception(
//             'File size mismatch: saved $savedSize bytes but downloaded ${response.bodyBytes.length} bytes',
//           );
//         }

//         print('💾 File saved to: $filePath');

//         // Load the downloaded file
//         _fileToPreview = file;
//         await _loadFileContent(_fileToPreview!);
//       } else {
//         print('❌ Download failed with status: ${response.statusCode}');
//         print('❌ Response headers: ${response.headers}');
//         print('❌ Response body: ${response.body}');
//         throw Exception(
//           'Failed to download file: ${response.statusCode} - ${response.body}',
//         );
//       }
//     } catch (e) {
//       print('❌ Error downloading file: $e');
//       setState(() {
//         isLoading = false;
//         errorMessage = 'Failed to download file: ${e.toString()}';
//       });
//     }
//   }

//   // Add this helper method to download via API
//   Future<http.Response> _downloadViaAPI(String documentId) async {
//     final url = Uri.parse(
//       '${AppUtils.baseUrl}/documents/download-document/$documentId',
//     );

//     print('📤 Downloading via API: $url');

//     return await http
//         .get(
//           url,
//           headers: {
//             'Accept': '*/*',
//             if (AppUtils.bearerToken != null &&
//                 AppUtils.bearerToken!.isNotEmpty)
//               'Authorization': 'Bearer ${AppUtils.bearerToken}',
//             if (AppUtils.sessionCookie != null &&
//                 AppUtils.sessionCookie!.isNotEmpty)
//               'Cookie': AppUtils.sessionCookie!,
//           },
//         )
//         .timeout(
//           const Duration(seconds: 60),
//           onTimeout: () => throw Exception('API download timed out'),
//         );
//   }

//   void _retryDownload() {
//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//     });
//     _initializePreview();
//   }

//   Future<void> _pickFileManually() async {
//     try {
//       setState(() {
//         isLoading = true;
//         errorMessage = null;
//       });

//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf', 'txt', 'doc', 'docx'],
//         allowMultiple: false,
//       );

//       if (result != null && result.files.single.path != null) {
//         final pickedFile = File(result.files.single.path!);

//         // Verify the file extension matches
//         final pickedExtension = result.files.single.extension?.toLowerCase();
//         if (pickedExtension != widget.fileExtension.toLowerCase()) {
//           setState(() {
//             isLoading = false;
//             errorMessage =
//                 'Selected file type (.$pickedExtension) does not match expected type (.${widget.fileExtension})';
//           });
//           return;
//         }

//         // Load the picked file
//         _fileToPreview = pickedFile;
//         await _loadFileContent(_fileToPreview!);
//       } else {
//         // User cancelled the picker
//         setState(() {
//           isLoading = false;
//           errorMessage = 'notAvailable';
//         });
//       }
//     } catch (e) {
//       print('❌ Error picking file: $e');
//       setState(() {
//         isLoading = false;
//         errorMessage = 'Error selecting file: ${e.toString()}';
//       });
//     }
//   }

//   Future<void> _loadFileContent(File file) async {
//     try {
//       final extension = widget.fileExtension.toLowerCase();

//       print('📄 Loading file with extension: $extension');
//       print('📍 File path: ${file.path}');
//       print('📏 File size: ${await file.length()} bytes');

//       if (extension == 'pdf') {
//         // Handle PDF - keep as binary
//         setState(() {
//           localFilePath = file.path;
//           isLoading = false;
//         });
//         print('✅ PDF file ready for preview at: $localFilePath');
//       } else if (extension == 'txt') {
//         // Handle TXT - ONLY read as text for TXT files
//         try {
//           final content = await file.readAsString();
//           setState(() {
//             textContent = content;
//             isLoading = false;
//           });
//           print(
//             '✅ TXT file loaded successfully (${content.length} characters)',
//           );
//         } catch (e) {
//           print('⚠️ UTF-8 decode failed, trying with allowMalformed');
//           // If UTF-8 fails, try reading as bytes and decode
//           final bytes = await file.readAsBytes();
//           setState(() {
//             textContent = utf8.decode(bytes, allowMalformed: true);
//             isLoading = false;
//           });
//           print('✅ TXT file decoded with allowMalformed');
//         }
//       } else if (extension == 'doc' || extension == 'docx') {
//         // For Word documents - DO NOT read as text, keep as binary
//         print('📝 Word document detected - keeping as binary file');

//         // Verify the file exists and has content
//         if (!await file.exists()) {
//           throw Exception('Word document file does not exist');
//         }

//         final fileSize = await file.length();
//         if (fileSize == 0) {
//           throw Exception('Word document file is empty');
//         }

//         setState(() {
//           localFilePath = file.path;
//           isLoading = false;
//         });
//         print('✅ Word document ready at: $localFilePath (${fileSize} bytes)');
//       } else {
//         setState(() {
//           isLoading = false;
//           errorMessage = 'Unsupported file type: .$extension';
//         });
//       }
//     } catch (e) {
//       print('❌ Error loading file content: $e');
//       setState(() {
//         isLoading = false;
//         errorMessage = 'Error loading file: $e';
//       });
//     }
//   }

//   Future<void> _openWithExternalApp() async {
//     if (localFilePath == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('File not available for opening'),
//           backgroundColor: Colors.orange,
//         ),
//       );
//       return;
//     }

//     try {
//       // For Android/iOS, you might want to use a package like open_file
//       // For now, show the file path
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('File saved at: $localFilePath'),
//           backgroundColor: Colors.green,
//           duration: const Duration(seconds: 5),
//           action: SnackBarAction(
//             label: 'Copy Path',
//             textColor: Colors.white,
//             onPressed: () {
//               // Copy to clipboard if needed
//             },
//           ),
//         ),
//       );
//     } catch (e) {
//       print('Error opening file: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
//       );
//     }
//   }

//   Widget _buildFileContent() {
//     final extension = widget.fileExtension.toLowerCase();

//     if (extension == 'pdf' && localFilePath != null) {
//       return PDFView(
//         filePath: localFilePath!,
//         enableSwipe: true,
//         swipeHorizontal: false,
//         autoSpacing: false,
//         pageFling: true,
//         pageSnap: true,
//         onRender: (pages) {
//           setState(() {
//             totalPages = pages ?? 0;
//           });
//         },
//         onPageChanged: (page, total) {
//           setState(() {
//             currentPage = page ?? 0;
//           });
//         },
//         onError: (error) {
//           print('❌ PDF Viewer Error: $error');
//           setState(() {
//             errorMessage = error.toString();
//           });
//         },
//         onPageError: (page, error) {
//           print('❌ PDF Page Error: $error');
//         },
//       );
//     } else if (extension == 'txt' && textContent != null) {
//       // Display text content
//       return Container(
//         color: Colors.white,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: SelectableText(
//             textContent!,
//             style: const TextStyle(
//               fontSize: 14,
//               height: 1.6,
//               color: Colors.black87,
//               fontFamily: 'monospace',
//             ),
//           ),
//         ),
//       );
//     } else if (extension == 'doc' || extension == 'docx') {
//       // For Word documents, show info that preview is not available
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.check_circle, size: 80, color: Colors.green.shade400),
//               const SizedBox(height: 24),
//               Text(
//                 widget.fileTitle,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Word Document (.${widget.fileExtension})',
//                 style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
//               ),
//               const SizedBox(height: 16),
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.green.shade50,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.green.shade200),
//                 ),
//                 child: Column(
//                   children: [
//                     const Icon(
//                       Icons.file_download_done,
//                       color: Colors.green,
//                       size: 32,
//                     ),
//                     const SizedBox(height: 8),
//                     const Text(
//                       'File Downloaded Successfully',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.green,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     if (localFilePath != null)
//                       Text(
//                         'Saved to: ${localFilePath!.split('/').last}',
//                         style: const TextStyle(
//                           fontSize: 11,
//                           color: Colors.grey,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),
//               const Text(
//                 'Word documents cannot be previewed in-app.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 14),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Please use Microsoft Word or compatible app to view.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 14, color: Colors.grey),
//               ),
//               const SizedBox(height: 24),
//               if (localFilePath != null)
//                 ElevatedButton.icon(
//                   onPressed: _openWithExternalApp,
//                   icon: const Icon(Icons.open_in_new),
//                   label: const Text('View File Location'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 12,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       );
//     }

//     return const Center(child: Text('Unsupported file type'));
//   }

//   PreferredSizeWidget? _buildPageIndicator() {
//     if (widget.fileExtension.toLowerCase() == 'pdf' && totalPages > 0) {
//       return PreferredSize(
//         preferredSize: const Size.fromHeight(40),
//         child: Container(
//           padding: const EdgeInsets.only(bottom: 8),
//           child: Text(
//             'Page ${currentPage + 1} of $totalPages',
//             style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
//           ),
//         ),
//       );
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.fileTitle,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             Text(
//               '.${widget.fileExtension.toUpperCase()}',
//               style: TextStyle(
//                 color: Colors.grey.shade600,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ],
//         ),
//         bottom: _buildPageIndicator(),
//       ),
//       body: isLoading
//           ? const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 16),
//                   Text('Loading file...'),
//                 ],
//               ),
//             )
//           : errorMessage != null
//           ? Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       errorMessage == 'notAvailable'
//                           ? Icons.file_download_outlined
//                           : Icons.error_outline,
//                       size: 64,
//                       color: errorMessage == 'notAvailable'
//                           ? Colors.blue.shade300
//                           : Colors.red.shade300,
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       errorMessage == 'notAvailable'
//                           ? 'File Not Available Locally'
//                           : 'Cannot Preview File',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.grey.shade800,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       errorMessage == 'notAvailable'
//                           ? 'This file is stored on the server.'
//                           : errorMessage!,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     if (errorMessage == 'notAvailable') ...[
//                       const Text(
//                         'To preview this file, you need to:',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.blue.shade50,
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(color: Colors.blue.shade200),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 24,
//                                   height: 24,
//                                   decoration: BoxDecoration(
//                                     color: Colors.blue,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: const Center(
//                                     child: Text(
//                                       '1',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 const Expanded(
//                                   child: Text(
//                                     'Download the file from your server/email',
//                                     style: TextStyle(fontSize: 13),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 12),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 24,
//                                   height: 24,
//                                   decoration: BoxDecoration(
//                                     color: Colors.blue,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: const Center(
//                                     child: Text(
//                                       '2',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 const Expanded(
//                                   child: Text(
//                                     'Click "Select File" below to choose it',
//                                     style: TextStyle(fontSize: 13),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 24),
//                       ElevatedButton.icon(
//                         onPressed: _pickFileManually,
//                         icon: const Icon(Icons.folder_open),
//                         label: const Text('Select File from Device'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primary,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 24,
//                             vertical: 14,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         'Expected file type: .${widget.fileExtension.toUpperCase()}',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey.shade600,
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                     ] else ...[
//                       const Text(
//                         'Unable to load the file for preview.',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontSize: 13, color: Colors.grey),
//                       ),
//                       const SizedBox(height: 16),
//                       ElevatedButton.icon(
//                         onPressed: _retryDownload,
//                         icon: const Icon(Icons.refresh),
//                         label: const Text('Retry Download'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.orange,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 24,
//                             vertical: 12,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         widget.fileUrl ?? 'No URL available',
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontSize: 11,
//                           color: Colors.grey,
//                           fontFamily: 'monospace',
//                         ),
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             )
//           : _buildFileContent(),
//     );
//   }
// }
