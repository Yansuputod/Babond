# Dokumentasi Splash Screen dan Launcher Icon

## Splash Screen

### Jenis Splash
Aplikasi menggunakan **native splash screen** dari package `flutter_native_splash`, bukan menggunakan halaman Flutter (`splash_page.dart`).

### Package yang Digunakan
```yaml
flutter_native_splash: ^2.3.5
```

### Konfigurasi di pubspec.yaml
```yaml
flutter_native_splash:
  color: "#FFFDEB" # warna latar belakang
  image: assets/icons/app_icon.png # logo yang ditampilkan
  android: true
  ios: true
```

### Cara Generate Splash
Jalankan perintah berikut:
```bash
flutter pub run flutter_native_splash:create
```

### Catatan
- Pastikan file logo sudah tersedia di `assets/icons/app_icon.png`.
- Tambahkan asset logo ke `flutter -> assets` jika belum:

```yaml
flutter:
  assets:
    - assets/icons/app_icon.png
```

---

## Launcher Icon

### Package yang Digunakan
```yaml
flutter_launcher_icons: ^0.13.1
```

### Konfigurasi
File konfigurasi diatur di `pubspec.yaml`:
```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icons/app_icon.png"
  remove_alpha_ios: true
```

### Cara Generate
Untuk membuat ikon:
```bash
flutter pub run flutter_launcher_icons:main
```

### Catatan
- Pastikan gambar yang digunakan memiliki resolusi tinggi (minimal 512x512 px).
- Gambar berada di path yang sesuai (`assets/icons/app_icon.png`).
- Tambahkan path gambar di bagian `flutter -> assets` kalau belum ada.

```yaml
flutter:
  assets:
    - assets/icons/app_icon.png
```

---

Kalau nanti ingin update ikon, tinggal ganti file PNG dan jalankan ulang perintah generate.

