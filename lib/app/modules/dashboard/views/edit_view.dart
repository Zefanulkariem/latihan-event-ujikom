import 'package:event_latihan/app/data/detail_event_response.dart';
import 'package:event_latihan/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class EditView extends GetView {
  const EditView({super.key, required this.id, required this.title});
  final int id;
  final String title;

  @override
  Widget build(BuildContext context) {
    // Nih, bikin controller buat ngurusin dashboard pake Get.put
    DashboardController controller = Get.put(DashboardController());
    return Scaffold(
      // AppBar nih, buat header atas. Judulnya "Add Your Event", terus ada di tengah biar estetik
      appBar: AppBar(
        title: const Text('Add Your Event'), // Judul biar kelihatan niat
        centerTitle: true, // Tengahin judul, biar vibes-nya enak
        backgroundColor: HexColor('#feeee8'), // Warna pastel biar soft
      ),
      // Latar belakang layar, warnanya pastel juga. Matching dong!
      backgroundColor: HexColor('#feeee8'),
      // Badan utama layar, isinya susunan widget
      body: SingleChildScrollView(
        child: FutureBuilder<DetailEventResponse>(
          future:
              controller.getDetailEvent(id: id), // Ambil detail event sesuai ID
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Kalau masih loading, kasih animasi lucu biar nggak boring
              return Center(
                child: Lottie.network(
                  'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                  repeat: true, // Animasi muter terus
                  width: MediaQuery.of(context).size.width / 1, // Lebar full
                ),
              );
            }
            if (snapshot.hasData) {
              // Kalau datanya udah ada, isi formnya otomatis
              controller.nameController.text = snapshot.data!.name!;
              controller.descriptionController.text = snapshot.data!.description!;
              controller.eventDateController.text = snapshot.data!.eventDate!;
              controller.locationController.text = snapshot.data!.location!;
            }
            return Column(
              children: [
                // Animasi lucu buat header, biar tampilannya fun
                Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: Lottie.network(
                    'https://gist.githubusercontent.com/olipiskandar/2095343e6b34255dcfb042166c4a3283/raw/d76e1121a2124640481edcf6e7712130304d6236/praujikom_kucing.json',
                    fit: BoxFit.cover, // Cocokin animasi ke layar
                  ),
                ),
                // Input buat nama event, langsung autofill dari server
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    autofocus: true, // Fokus langsung ke input pertama
                    controller:
                        controller.nameController, // Controller buat nama
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(), // Border rapi
                      labelText: 'Event Name', // Label form
                      hintText: 'Masukin nama Eventnya!', // Petunjuk input
                    ),
                  ),
                ),
                // Input deskripsi event
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: TextField(
                    controller: controller
                        .descriptionController, // Controller deskripsi
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                      hintText: 'Masukin Deskripsi!',
                    ),
                  ),
                ),
                // Input tanggal event, bisa dipilih lewat date picker
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller:
                        controller.eventDateController, // Controller tanggal
                    readOnly: true, // Supaya cuma bisa diubah lewat picker
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Event Date',
                      hintText: 'Masukin Tanggal Event',
                    ),
                    onTap: () async {
                      // Date picker buat pilih tanggal
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), // Mulainya dari hari ini
                        firstDate: DateTime(2024), // Minimal 2024
                        lastDate: DateTime(2100), // Maksimal 2100
                      );
                      // Kalau tanggal dipilih, langsung di-set ke controller
                      if (selectedDate != null) {
                        controller.eventDateController.text =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                      }
                    },
                  ),
                ),
                // Input lokasi event
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: TextField(
                    controller:
                        controller.locationController, // Controller lokasi
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Location',
                      hintText: 'Masukin Lokasi Event juga!',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10, // Jarak biar nggak nempel
                ),
                // Tombol save buat nyimpen perubahan
                Container(
                  height: 50, // Tinggi tombol
                  width: 150, // Lebar tombol
                  decoration: BoxDecoration(
                    color: Colors.blue, // Warna biru biar mencolok
                    borderRadius: BorderRadius.circular(20), // Sudut rounded
                  ),
                  child: TextButton(
                    onPressed: () {
                      controller.editEvent(id: id); // Aksi edit event
                    },
                    child: const Text(
                      'Save', // Teks tombol "Save"
                      style: TextStyle(
                        color: Colors.white, // Teks putih biar kontras
                        fontSize: 25, // Ukuran teks gede
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
