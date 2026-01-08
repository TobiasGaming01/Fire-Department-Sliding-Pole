# Feuerwehr Rutschstange System

Ein FiveM Resource für Feuerwehr-Rutschstangen mit ESX Integration.

## Features

- 🚒 **Rutschstangen-System**: Feuerwehrleute können durch Rutschstangen von oberen Etagen nach unten gleiten
- 📍 **Multi-Location Support**: Unterstützung für mehrere Feuerwachen mit unterschiedlichen Rutschstangen
- 🎬 **Animiertes Gleiten**: Fließende Animationen während des Rutschvorgangs
- 🎯 **ox_target Integration**: Moderne Target-System Unterstützung
- 🔧 **Konfigurierbar**: Vollständig anpassbar über die Config-Datei
- 👨‍🚒 **Job-System**: Nur Feuerwehrleute können Rutschstangen nutzen
- 🐛 **Debug-Modus**: Marker-Anzeige für Rutschstangen-Standorte

## Installation

1. Lade das Resource in deinen `resources` Ordner
2. Stelle sicher dass `es_extended` installiert ist
3. Füge `ensure Feuerwerhrsystem` zu deiner `server.cfg` hinzu
4. Starte den Server neu

## Konfiguration

### Hauptkonfiguration (config.lua)

```lua
-- Debug-Einstellungen
Config.Debug = false          -- Marker für Rutschstangen anzeigen
Config.marker = false         -- Zusätzliche Debug-Marker

-- Interaktions-Einstellungen
Config.DistanceToPole = 1.2   -- Entfernung zur Rutschstange
Config.UsePoleControl = 51    -- Taste (51 = E)
Config.PoleSpeed = 0.1        -- Rutschgeschwindigkeit

-- ox_target
Config.ox_target = true       -- ox_target nutzen (false = Proximity)

-- 3D Text
Config.Text3d = true          -- 3D Text anzeigen
```

### Rutschstangen-Standorte

```lua
Config.PoleLocations = {
    ["Feuerwache 1"] = {
        ["Start Locations"] = {
            vector3(964.9288, -2538.4819, 31.5014)  -- Oben
        },
        ["End Z Coordinate"] = 27.5014,  -- Unten
        ["Heading"] = 62.2247             -- Blickrichtung
    }
}
```

## Befehle

### Spieler
- `/checkpole` - Überprüft ob das System aktiv ist

### Admin
- `/reloadpoleconfig` - Lädt die Konfiguration neu

### Tasten
- `E` - Rutschstange benutzen (wenn in der Nähe)

## Animationen

Standardmäßig wird die `missrappel` Animation mit `rope_idle` verwendet:

```lua
Config.Animations = {
    dict = "missrappel",
    anim = "rope_idle"
}
```

## Spracheinstellungen

```lua
Config.Language.UsePole = "Drücke E um die Rutschstange zu benutzen"
```

## Abhängigkeiten

- **ESX Framework** (erforderlich)
- **ox_target** (optional, für moderne Interaktion)

## Dateistruktur

```
Feuerwerhrsystem/
├── fxmanifest.lua      # Resource-Manifest
├── config.lua          # Konfigurationsdatei
├── client.lua          # Client-seitige Logik
├── server.lua          # Server-seitige Logik
├── system/
│   └── Rutschstange.lua # Zusätzliche System-Logik
└── README.md           # Diese Datei
```

## Debug-Modus

Aktiviere den Debug-Modus in der Config:

```lua
Config.Debug = true
Config.marker = true
```

Dies zeigt Marker an allen Rutschstangen-Standorten im Spiel an.

## Troubleshooting

### Rutschstange funktioniert nicht
1. Überprüfe ob du Feuerwehr-Job hast (`job.name = 'fire'`)
2. Stelle sicher dass du nah genug an der Rutschstange bist
3. Prüfe ob ox_target korrekt installiert ist

### Marker werden nicht angezeigt
1. Setze `Config.Debug = true`
2. Setze `Config.marker = true`
3. Starte das Resource neu

### Keine Animation
1. Überprüfe die Animations-Daten in der Config
2. Stelle sicher dass die Animation im Spiel geladen ist

## Updates

### v1.0.0
- Initiales Release
- ox_target Integration
- Multi-Location Support
- Debug-Modus
- Config-Reload Funktion

## Support

Bei Problemen oder Fragen erstelle eine Issue im GitHub Repository oder kontaktiere den Entwickler.

## Lizenz

Dieses Resource wurde für den FiveM-Server entwickelt und darf frei verwendet werden.
