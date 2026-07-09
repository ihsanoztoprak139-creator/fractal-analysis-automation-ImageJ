# Methodology

## Introduction

This document describes the methodological workflow implemented in the **Fractal Analysis Automation for ImageJ** macro.

The workflow is designed to standardize fractal dimension analysis by automating common image preprocessing and quantitative analysis steps while preserving reproducibility.

---

## Workflow Overview

```text
Input Image
↓
Region of Interest (ROI)
↓
Image Duplication
↓
Gaussian Blur
↓
Background Subtraction
↓
Contrast Enhancement
↓
Automatic Thresholding
↓
Binary Image Generation
↓
Skeletonization
↓
Fractal Dimension Analysis
↓
Result Export
```

---

## Region of Interest Selection

The user manually selects the region of interest before executing the macro.

Only the selected ROI is processed.

### Purpose

- Reduce irrelevant structures
- Standardize the analysis area
- Improve reproducibility

---

## Gaussian Blur Filtering

A Gaussian blur filter is applied to reduce high-frequency image noise.

### Purpose

- Smooth small pixel variations
- Improve threshold stability
- Reduce noise-related artifacts

---

## Background Subtraction

Background intensity variation is corrected before segmentation.

### Purpose

- Reduce uneven illumination
- Improve structural visibility
- Increase segmentation consistency

---

## Contrast Enhancement

Image contrast is enhanced to improve visual separation between structures and background.

### Purpose

- Improve visibility of structural patterns
- Support more stable thresholding

---

## Thresholding

Automatic thresholding converts the grayscale image into a binary image.

### Purpose

- Separate foreground structures from background
- Standardize segmentation
- Prepare the image for binary morphology analysis

---

## Binary Image Generation

The thresholded image is converted into a binary representation.

### Purpose

- Represent structural features in a simplified form
- Prepare the image for skeletonization and fractal analysis

---

## Skeletonization

Binary structures are reduced to one-pixel-wide skeletons.

### Purpose

- Preserve structural topology
- Reduce thickness dependency
- Support morphology-based analysis

---

## Fractal Dimension Analysis

Fractal dimension is calculated using the box-counting method.

### Purpose

- Quantify structural complexity
- Generate reproducible numerical measurements
- Support comparative image-based analysis

---

## Output Generation

The macro can generate:

- Processed images
- Binary images
- Skeletonized images
- Fractal dimension results
- Quantitative measurement outputs

---

## Reproducibility Considerations

Automating the workflow reduces user-dependent variability and improves consistency between repeated analyses.

Manual ROI selection remains the main user-dependent step and should be standardized across datasets.