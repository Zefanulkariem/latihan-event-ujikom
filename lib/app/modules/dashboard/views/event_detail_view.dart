import 'package:event_latihan/app/data/event_response.dart';
import 'package:event_latihan/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:event_latihan/app/modules/dashboard/views/edit_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class EventDetailView extends GetView {
  final Events event;
  const EventDetailView({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name!),
        centerTitle: true,
      ),
      body: Padding(
        // Memberikan padding di seluruh body
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          // Menggunakan Obx untuk mendengarkan perubahan pada yourEvents
          if (controller.yourEvents.isEmpty) {
            // Jika tidak ada event, tampilkan pesan bahwa data kosong
            return const Center(child: Text("Engga ada data nih"));
          }
          return ListView.builder(
            itemCount: controller
                .yourEvents.length, // Menentukan jumlah item pada ListView
            shrinkWrap: true, // Menyesuaikan ukuran ListView dengan konten
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Menyusun elemen-elemen secara vertikal
                children: [
                  // Menampilkan gambar event
                  Image.network(
                    'https://picsum.photos/id/${event.id}/700/300', // URL gambar berdasarkan ID event
                    fit: BoxFit.cover, // Menyesuaikan gambar agar memenuhi area
                    height: 200, // Mengatur tinggi gambar
                    width: 500, // Mengatur lebar gambar
                    errorBuilder: (context, error, stackTrace) {
                      // Jika gambar gagal dimuat, tampilkan pesan error
                      return const SizedBox(
                        height: 200,
                        child: Center(
                            child: Text(
                                'Duh, Gambarnya engga ada!')), // Tampilkan teks "Image not found"
                      );
                    },
                  ),
                  const SizedBox(height: 16), // Memberikan jarak antar elemen
                  Text(
                    'Event: ${event.name!}', // Menampilkan nama event
                    style: const TextStyle(
                      fontSize: 24, // Ukuran font untuk nama event
                      fontWeight:
                          FontWeight.bold, // Membuat nama event menjadi tebal
                    ),
                  ),
                  const SizedBox(
                      height:
                          8), // Memberikan jarak antara teks nama dan deskripsi
                  Row(
                    // Menampilkan lokasi event di dalam row
                    children: [
                      const Icon(
                        Icons.location_on, // Ikon lokasi
                        color: Colors.red, // Warna ikon lokasi
                      ),
                      const SizedBox(
                          width: 8), // Memberikan jarak antara ikon dan teks
                      Expanded(
                        // Membuat teks lokasi mengisi ruang yang tersedia
                        child: Text(
                          'lokasi:${event.location!}', // Menampilkan lokasi event
                          style: const TextStyle(
                            fontSize: 16, // Ukuran font untuk lokasi
                            color: Colors.black, // Warna teks lokasi
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                      height: 16), // Memberikan jarak setelah deskripsi
                  Text(
                    'Tanggal Event: ${event.eventDate!}', // Menampilkan deskripsi event
                    style: const TextStyle(
                      fontSize: 16, // Ukuran font untuk deskripsi
                      color: Colors.grey, // Warna teks deskripsi
                    ),
                  ),
                  const SizedBox(
                      height: 16), // Memberikan jarak setelah deskripsi
                  Text(
                    event.description!, // Menampilkan deskripsi event
                    style: const TextStyle(
                      fontSize: 16, // Ukuran font untuk deskripsi
                      color: Colors.grey, // Warna teks deskripsi
                    ),
                  ),
                  Divider(height: 10),
                  Text(
                    'Dibuat Oleh: ${event.dibuatOleh}',
                    style: const TextStyle(
                      fontSize: 16, // Ukuran font untuk deskripsi
                      color: Colors.grey, // Warna teks deskripsi
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
