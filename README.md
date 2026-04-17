# IIQ_to_JPEG_converter

A batch processing tool for converting **Phase One IIQ RAW** image files to high-quality JPEG format. Built for aerial survey workflows at DPIRD, where thousands of high-resolution captures need fast, consistent conversion with full metadata preservation.

The converter automatically matches the brightness and colour characteristics of the camera's original preview, producing output identical to what you see in IX Capture or other Phase One software.

---

## Features

- **Batch conversion** — process thousands of IIQ files in one run
- **Parallel processing** — up to 64 threads, auto-detected to your CPU
- **Brightness matching** — uses the embedded camera preview as reference
- **EXIF preservation** — camera info, capture settings, lens data, GPS coordinates, copyright
- **Automatic resume** — interrupted conversions pick up where they left off
- **Folder structure preservation** — maintain input directory hierarchy or flatten to a single folder
- **Colour space selection** — Adobe RGB (1998) or sRGB output
- **Session logging** — detailed per-file success/failure log with timestamps
- **Zero-install for end users** — self-bootstrapping Python environment, no admin rights needed

---

## Quick Start

### 1. Download

Place both files in the same folder:

```
C:\IIQ_Converter\
├── IIQ_Converter_Encrypted.bat
└── iiq_converter_encrypted.pye
```

### 2. First Run

Double-click **`IIQ_Converter_Encrypted.bat`**.

On first launch the script will automatically:
1. Download a portable Python 3.11.9 environment (~25 MB)
2. Install dependencies (`rawpy`, `Pillow`, `numpy`, `imageio`, `psutil`, `piexif`)
3. Open the converter GUI

This takes 2–3 minutes and only happens once. Subsequent launches are instant.

### 3. Convert

1. Select your **Input Folder** containing `.iiq` files (subfolders are searched automatically)
2. Select an **Output Folder** for the converted JPEGs
3. Click **▶ Start Conversion**

---

## Settings

| Setting | Description | Default |
|---|---|---|
| JPEG Quality | Compression quality, 1–100 | 100 (maximum) |
| Parallel Threads | Simultaneous conversions | CPU cores − 1 |
| Preserve Folder Structure | Mirror input hierarchy in output | Enabled |
| Colour Space | Adobe RGB (1998) or sRGB | Adobe RGB (1998) |

---

## System Requirements

| Component | Requirement |
|---|---|
| OS | Windows 7+ (64-bit) |
| RAM | 8 GB minimum, 16 GB+ recommended |
| Disk | ~150 MB for the environment + output space |
| Internet | First run only (~50 MB download) |

No administrator privileges required. The entire environment lives inside the `_python_env` subfolder.

---

## EXIF Metadata

All preserved metadata fields are copied from the source IIQ to the output JPEG:

- Camera make, model, serial number
- ISO, shutter speed, aperture, focal length, date/time
- Lens make, model, serial number
- GPS latitude, longitude, altitude
- Artist, copyright, creator

---

## Resume Capability

If a conversion is interrupted (power loss, disk full, manual stop), simply re-run with the same input and output folders. The tool reads `bin/log.txt` in the output directory, skips completed files, re-verifies the last incomplete batch, and continues.

---

## Logging

Each session appends to:

```
<Output Folder>/bin/log.txt
```

The log records a timestamp per batch, per-file success (✓) or failure (✗) with error details, and batch-level summaries.

---

## Troubleshooting

| Issue | Fix |
|---|---|
| "Failed to download Python" | Check internet / firewall; tool needs ~50 MB on first run |
| Slow conversion | Reduce parallel threads — start at 4 and increase |
| Some files failed | Check `bin/log.txt`; usually corrupt IIQ or low disk space |
| Missing EXIF in output | Source IIQ may lack embedded EXIF — verify with ExifTool |
| App won't start | Delete the `_python_env` folder and re-run the `.bat` to reinstall |
| "Decompression bomb" warning | Normal for 100 MP+ Phase One images; conversion proceeds fine |

---

## Uninstalling

Delete the folder. That's it — no registry entries, no system-wide changes. Already-converted JPEGs are unaffected.

---

## File Structure

```
IIQ_Converter/
├── IIQ_Converter_Encrypted.bat    # Launcher & first-run bootstrapper
├── iiq_converter_encrypted.pye    # Application (compiled Python)
├── _python_env/                   # Auto-created on first run
│   ├── python/                    # Portable Python 3.11.9
│   └── .setup_complete            # Marker file
└── How_to_Install_and_Use.pdf     # User guide
```

---

## Author

**Bipul Neupane, PhD**
Research Scientist — DPIRD Node, APPN
bipul.neupane@dpird.wa.gov.au

## Contributor
Bipul Neupane
Github: [bipulneupane](https://github.com/bipulneupane)
