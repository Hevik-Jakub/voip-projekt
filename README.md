# VoIP Projekt — Téma #10: Časově podmíněné směrování v Asterisku
*Autor: glu0025 (VŠB-TUO FEIK)*

## 1. Úvod
Tento projekt se zabývá návrhem a implementací časově podmíněného směrování příchozích hovorů v IP telefonní ústředně Asterisk (Téma #10). Cílem je automaticky vyhodnocovat pracovní dobu organizace a podle aktuálního času směrovat hovory buď na dostupné pracoviště (recepci), nebo na automatickou hlášku mimo pracovní dobu.

## 2. Současný stav problematiky
V moderních VoIP systémech je časové směrování základní funkcí pro řízení toku hovorů (IVR/Call centra). Asterisk umožňuje zápis řídicí logiky (dialplanu) ve více konfiguračních jazycích:
- **`extensions.conf`**: Tradiční a nejrozšířenější formát s využitím aplikací jako `GotoIfTime`.
- **`extensions.ael`** (Asterisk Extension Language): C-like strukturovaný jazyk podporující blokové podmínky `ifTime`.
- **`extensions.lua`**: Skriptovací rozhraní využívající jazyk Lua pro pokročilou dynamickou logiku.

## 3. Podrobný popis konfigurace a srovnání jazyků

### Implementovaná logika (Pracovní doba: Po–Pá 08:00–16:00)
- **Vyzvánění na linku 200** $\rightarrow$ kontrola času.
- **OTEVŘENO:** Hovor směrován na recepci (`PJSIP/101`).
- **ZAVŘENO:** Přehrání zvuku `tt-monkeys` a zavěšení (`Hangup`).

### Srovnání syntaxe

| Vlastnost | `extensions.conf` | `extensions.ael` | `extensions.lua` |
|---|---|---|---|
| **Styl zápisu** | Sekvenční (prioritní řádky `1, n`) | Strukturovaný (C-like bloky `{}`) | Skriptovací (LUA tabulky/funkce) |
| **Časová podmínka** | `GotoIfTime(...)` | `ifTime (...) { ... } else { ... }` | `app.gotoiftime(...)` |
| **Čitelnost** | Nižší při složitém větvení | Vysoká a přehledná | Vysoká pro vývojáře |

## 4. Důkazový balíček

### A. Repozitář a commit historie
- Git repozitář obsahuje historii commitů napříč 10.–13. týdnem.

### B. Výpisy z Asterisk CLI (Logy)
- **Stav ZAVŘENO (Mimo pracovní dobu):** Viz [`docs/logs/test_call_closed.log`](docs/logs/test_call_closed.log)
- **Stav OTEVŘENO + RTP přenos:** Viz [`docs/logs/test_call_open_rtp.log`](docs/logs/test_call_open_rtp.log)

### C. Demo video
- Odkaz na demo video (2–3 minuty): *[Bude doplněno před odevzdáním]*

## 5. Závěr a vlastní přínos
Projekt ověřil funkčnost časového směrování v prostředí WSL2 s protokolem PJSIP. AEL se ukázal jako nejpřehlednější formát pro zápis složitější podmíněné logiky dialplanu.

## 6. Reference
1. Asterisk Documentation: *Dialplan Applications & GotoIfTime*.
2. Zadání semestrálního projektu VoIP FEI VŠB-TUO.
