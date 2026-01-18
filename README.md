<<<<<<< HEAD
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
=======
[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/VcFknM5q)
[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=21969002&assignment_repo_type=AssignmentRepo)
# Flutter: Geo Journal

## Cel
Stwórz podstawową aplikację w **Flutter (Dart)** z **natywną funkcją** oraz **komunikacją z API**, zawierającą **3–4 widoki**.

## Zakres i wymagania funkcjonalne
- **Natywna funkcja (min. 1):** wybierz i uzasadnij (np. lokalizacja GPS, aparat/kamera, udostępnianie/clipboard, czujniki).
- **API (min. 1 endpoint):** odczyt listy wpisów lub zapis nowego.
- **Widoki (3–4):**
  1. **Mapa/Lista wpisów** (pin/pozycja lub lista z datą i miejscem).
  2. **Szczegóły wpisu** (opis, zdjęcie/lokalizacja, akcje).
  3. **Dodaj wpis** (formularz: tytuł, opis, przycisk „pobierz lokalizację” **lub** „zrób zdjęcie”).
  4. *(Opcjonalnie)* **Ustawienia** (np. motyw jasny/ciemny).
- **Nawigacja:** przejścia między widokami z przekazaniem identyfikatora.
- **UX:** komunikaty o błędach, pusty stan, stany ładowania.


## Testowanie lokalne (w trakcie developmentu)
- Uruchom na **emulatorze/urządzeniu**.
- Pokaż: dodanie wpisu z **natywną funkcją** (GPS/zdjęcie), pojawienie się na liście/mapie.
- Pokaż komunikację z **API** (pobranie/zapis), zachowanie bez internetu/bez uprawnień.

## Definition of Done (DoD)
- [ ] 3–4 widoki, kompletna nawigacja.
- [ ] Co najmniej 1 **natywna funkcja**.
- [ ] Co najmniej 1 operacja **API** (GET/POST).
- [ ] Stany: ładowanie, błąd, pusty.
- [ ] `README.md`, zrzuty ekranów, min. 3 commity.
>>>>>>> 33b2660b0a3fc8fcd5561d6cb321b9588d124eb4
