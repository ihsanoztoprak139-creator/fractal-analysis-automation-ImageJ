# fractal-analysis-automation-ImageJ

An automated ImageJ macro for fractal dimension analysis and image-based quantitative morphology assessment.

This repository provides a reproducible ImageJ/Fiji workflow for preprocessing images, generating binary and skeletonized outputs, and performing fractal box-counting analysis.

---

## Overview

Fractal analysis is commonly used to quantify complex structural patterns in biological, medical, and material images.  
This ImageJ macro was developed to automate repetitive image-processing steps and standardize fractal dimension analysis.

The workflow can be adapted for different image-based research applications, including trabecular bone analysis, dental radiographs, microscopic images, histological sections, and porous material structures.

---

## Features

- Automated image preprocessing
- ROI-based analysis
- Gaussian blur filtering
- Background subtraction
- Contrast enhancement
- Automatic thresholding
- Binary image generation
- Skeletonization
- Fractal dimension analysis using box counting
- Export of processed images and quantitative results

---

## Repository Structure

```text
fractal-analysis-automation-ImageJ
│
├── macro
│   └── fractal_analysis_automation.ijm
│
├── docs
│
├── images
│
├── example_input
│
├── example_output
│
├── publications
│
├── README.md
└── LICENSE

---

## Requirements

- Fiji / ImageJ (recommended)
- ImageJ Macro Language
- Analyze Skeleton plugin (if required)

---

## Installation

1. Clone or download this repository.
2. Open Fiji/ImageJ.
3. Navigate to:

Plugins → Macros → Run...

4. Select:

macro/fractal_analysis_automation.ijm

5. Execute the macro.

---

## General Workflow

Input Image

↓

ROI Selection

↓

Preprocessing

↓

Background Subtraction

↓

Thresholding

↓

Binary Conversion

↓

Skeletonization

↓

Fractal Dimension Analysis

↓

Export Results

---

## Applications

This workflow can be adapted for:

- Dental radiographs
- Trabecular bone analysis
- Histological images
- Microscopy
- Material science
- Biological image analysis

---

## Author

**Mehmet Ihsan Oztoprak**

Department of Bioengineering

Marmara University

---

## License

MIT License