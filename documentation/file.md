## 📆 Struktur Folder Flutter - Clean Architecture + BLoC + Web Scraping

```bash
lib/
│
├── core/
│   ├── constants/          # Konstanta global (warna, string tetap, dll)
│   ├── error/              # Kelas error dan exception
│   └── utils/              # Fungsi bantu (misal date formatter, validator)
│
├── data/
│   ├── datasources/
│   │   ├── remote/         # Web scraping / API call
│   │   └── local/          # Local storage (opsional)
│   ├── models/             # Model data dari API/scraping (pakai fromJson)
│   └── repositories/       # Implementasi repository dari domain
│
├── domain/
│   ├── entities/           # Struktur data murni (tanpa fromJson)
│   ├── repositories/       # Interface repository (dijembatani oleh data/)
│   └── usecases/           # Logika bisnis (ambil data, olah data)
│
├── presentation/
│   ├── bloc/               # State management (BLoC)
│   ├── pages/              # Halaman utama (HomePage, InfoPage, dll)
│   └── widgets/            # Komponen UI reusable (Card, ListTile, dll)
│
└── main.dart               # Entry point aplikasi
```

---

## 🧠 Penjelasan Per Folder

### 🔹 core/
Folder untuk kebutuhan global yang sering dipakai lintas modul.

- `constants/`: File seperti `app_colors.dart`, `app_strings.dart`.
- `error/`: File seperti `failure.dart`, `exception.dart`.
- `utils/`: Fungsi bantu seperti `date_formatter.dart`, `string_helper.dart`.

---

### 🔹 data/
Layer pengambil dan pengelola data (web scraping, API, local).

- `datasources/remote/`: Web scraping (contoh: `scraper_service.dart`) atau API client.
- `models/`: Model hasil parsing (`InfoModel`, `BabiModel`, dll).
- `repositories/`: Implementasi dari `domain/repositories`.

---

### 🔹 domain/
Layer logika bisnis murni, tidak bergantung pada Flutter.

- `entities/`: Struktur data dasar (`Info`, `Babi`, dsb).
- `repositories/`: Interface repo (digunakan oleh usecases dan diimplementasi di `data/`).
- `usecases/`: File seperti `get_info_usecase.dart`, `get_babi_list.dart`.

---

### 🔹 presentation/
UI dan state management (BLoC).

- `bloc/`: Misal `info_bloc.dart`, `babi_bloc.dart`.
- `pages/`: Halaman utama (`HomePage`, `SplashPage`, dsb).
- `widgets/`: UI kecil yang bisa dipakai ulang (misal `InfoCard`, `CustomButton`).

---

## 🔄 Alur Aplikasi

```mermaid
UI (presentation/pages)
   ↓
Event → BLoC → UseCase (domain/usecases)
                         ↓
                   Repository Interface
                         ↓
             Repository Implementasi (data/)
                         ↓
          API / Scraper / Local Storage (datasources)
```

---

## 🌐 Web Scraping

Contoh integrasi scraping info peternakan:

- `data/datasources/remote/scraper_service.dart`: Parsing HTML (pakai `html` atau `http` package).
- `data/models/info_model.dart`: Model dari hasil parsing.
- `domain/entities/info.dart`: Struktur bersih.
- `domain/usecases/get_info_usecase.dart`: Ambil info dari scraper.
- `presentation/bloc/info_bloc.dart`: Handle loading, success, error state.
- `presentation/pages/info_page.dart`: Tampilkan datanya ke UI.