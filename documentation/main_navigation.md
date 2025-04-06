# Dokumentasi: Main Navigation - Babond App

## Deskripsi
`MainNavigation` adalah komponen utama navigasi bawah (bottom navigation) dalam aplikasi Babond. Komponen ini mengatur transisi antar halaman utama aplikasi yang terdiri dari tiga tab: Home, Cage (Kandang), dan Informasi.

---

## File Terkait
- `main_navigation.dart`
- `home_page.dart`
- `kandang_page.dart`
- `informasi_page.dart`
- `app_colors.dart` (untuk styling warna)

---

## Struktur Navigasi
```dart
final List<Widget> _pages = [
  const HomePage(),
  const KandangPage(),
  const InformasiPage(),
];
```
Halaman-halaman yang tersedia:
- **HomePage**: Berisi konten utama aplikasi
- **KandangPage** (label: Cage): Informasi dan pengelolaan kandang babi
- **InformasiPage**: Berisi info, berita, atau edukasi untuk pengguna

---

## AppBar
```dart
AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  leading: IconButton(
    icon: Icon(Icons.notifications_none_rounded, color: AppColors.pinkDark),
    onPressed: () {},
  ),
  centerTitle: true,
  title: Text(
    'Babond',
    style: TextStyle(
      color: AppColors.pinkDark,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
  actions: [
    IconButton(
      icon: Icon(Icons.settings_rounded, color: AppColors.pinkDark),
      onPressed: () {},
    ),
  ],
)
```
AppBar ini konsisten di semua halaman utama dengan warna dasar putih, ikon notifikasi di kiri, dan ikon pengaturan di kanan. Judul "Babond" berada di tengah dan ditebalkan.

---

## BottomNavigationBar
```dart
BottomNavigationBar(
  currentIndex: _currentIndex,
  backgroundColor: Colors.white,
  selectedItemColor: AppColors.pinkDark,
  unselectedItemColor: AppColors.pinkDark.withOpacity(0.5),
  onTap: (index) => setState(() => _currentIndex = index),
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.pets_rounded), label: 'Cage'),
    BottomNavigationBarItem(icon: Icon(Icons.info_rounded), label: 'Informasi'),
  ],
)
```
Warna utama navigasi adalah `AppColors.pinkDark` untuk item yang aktif, dan warna lebih transparan untuk yang tidak aktif.

---

## Behavior
- Saat item navbar diklik, halaman akan berubah sesuai index.
- Judul dan AppBar tetap konsisten di semua halaman.

---

## Rencana Pengembangan
- **Notifikasi dan Pengaturan**: Fungsi tombol akan diisi
- **Badge Notifikasi**: Tambahan indikator notifikasi
- **Animasi Transisi**: Tambahkan animasi saat berpindah tab
- **Responsif**: Optimasi tampilan untuk berbagai ukuran layar

---

## Saran Struktur Folder
```
lib/
├── features/
│   ├── home/
│   │   ├── pages/
│   │   │   └── home_page.dart
│   ├── kandang/
│   │   ├── pages/
│   │   │   └── kandang_page.dart
│   ├── informasi/
│   │   ├── pages/
│   │   │   └── informasi_page.dart
├── core/
│   ├── constants/
│   │   └── app_colors.dart
├── main_navigation.dart
```

---

## Penutup
`MainNavigation` adalah pusat navigasi utama aplikasi Babond. Dengan desain bersih dan pemisahan halaman yang jelas, struktur ini mendukung pengembangan fitur selanjutnya secara modular dan terarah.

