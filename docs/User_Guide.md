# User Guide

## Fractal Analysis Automation for ImageJ

This guide explains how to run the ImageJ macro and perform a standardized fractal analysis workflow.

---

## Requirements

- Fiji / ImageJ
- Input image suitable for binary or skeleton-based analysis
- Manually selected region of interest, if ROI-based analysis is required

---

## How to Run the Macro

1. Open Fiji/ImageJ.
2. Open the image to be analyzed.
3. Select the region of interest using the ROI tools.
4. Go to:

```text
Plugins → Macros → Run...
```

5. Select:

```text
macro/fractal_analysis_automation.ijm
```

6. Run the macro.

---

## Recommended Input

Use images with:

- sufficient contrast
- minimal motion blur
- consistent acquisition settings
- standardized resolution
- clearly visible structural patterns

Do not use patient-identifiable or confidential images in public repositories.

---

## Expected Workflow

```text
Open Image
↓
Select ROI
↓
Run Macro
↓
Preprocessing
↓
Thresholding
↓
Skeletonization
↓
Fractal Analysis
↓
Export Results
```

---

## Output Files

Depending on the macro settings, the workflow may generate:

- processed image
- binary image
- skeletonized image
- quantitative measurement results
- fractal dimension results

---

## Notes for Reproducibility

For reliable comparison between images:

- use the same image resolution
- apply consistent ROI selection criteria
- use the same preprocessing parameters
- analyze images under similar acquisition conditions
- document all parameter settings

---

## Troubleshooting

### No ROI selected

Select a region of interest before running the macro.

### Poor thresholding result

Check image contrast and background quality before analysis.

### Skeleton image looks fragmented

Review image quality, thresholding, and preprocessing parameters.

### Output files are missing

Check whether the macro has permission to write files to the selected directory.

---

## Disclaimer

This macro is intended for research and educational purposes. It is not intended for clinical diagnosis or medical decision-making.