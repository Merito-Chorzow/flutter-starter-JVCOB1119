# Flutter: Geo Journal (Flutter Entries App)

Prosta aplikacja mobilna w **Flutter (Dart)** do tworzenia wpisów dziennika z możliwością pobrania **lokalizacji GPS** oraz komunikacją z **API (JSON Server)**.

---

## Cel projektu
Celem projektu jest zbudowanie aplikacji Flutter spełniającej wymagania:
- 3–4 widoki + nawigacja między nimi (z przekazaniem ID),
- min. 1 natywna funkcja (GPS),
- min. 1 operacja API (GET/POST) – w projekcie: GET/POST/GET by ID/DELETE,
- UX: stany ładowania, błędu i pustej listy.

---

## Funkcje aplikacji
### Widoki (3)
1. **Lista wpisów**
   - pobieranie danych z API (GET `/entries`)
   - odświeżanie (pull-to-refresh)
   - stany: loading / error / empty
   
2. **Dodaj wpis**
   - formularz: tytuł, opis
   - przycisk **„Pobierz lokalizację”** (GPS)
   - zapis do API (POST `/entries`)
   - stany: loading / error

3. **Szczegóły wpisu**
   - pobieranie po ID (GET `/entries/:id`)
   - akcja **Usuń wpis** (DELETE `/entries/:id`)
   - stany: loading / error

---

## Natywna funkcja (GPS)
Aplikacja wykorzystuje pakiet `geolocator` do pobrania aktualnej lokalizacji użytkownika:
- obsługa braku włączonej usługi lokalizacji (GPS),
- obsługa odmowy uprawnień oraz blokady „denied forever”,
- zapis `lat` i `lng` do wpisu w API.

---

## API (JSON Server)
Do obsługi danych używany jest **JSON Server**.

### Endpointy:
- `GET /entries` – lista wpisów
- `POST /entries` – dodanie wpisu
- `GET /entries/:id` – szczegóły wpisu
- `DELETE /entries/:id` – usunięcie wpisu

---

## Uruchomienie projektu

### 1) Wymagania
- Flutter SDK
- Android Studio + emulator lub telefon z debugowaniem USB
- Node.js (do JSON Server)

### 2) Backend – uruchom JSON Server
W katalogu projektu utwórz plik `db.json` (jeśli nie istnieje), np.:

```json
{
  "entries": [
    {
      "id": 1,
      "title": "Pierwszy wpis",
      "description": "Testowy wpis",
      "date": "2026-01-18",
      "lat": 50.2649,
      "lng": 19.0238
    }
  ]
}
