//=============================================================================
// Fractal Analysis Automation for ImageJ
// Version: 1.0.0
// Author: Mehmet Ihsan Oztoprak
// Department of Bioengineering, Marmara University
//
// Description:
// Fully automated ImageJ macro for fractal dimension analysis,
// skeleton analysis, and quantitative image preprocessing.
//
// Copyright (c) 2026 Mehmet Ihsan Oztoprak
//=============================================================================


//=============================================================================
// CONFIGURATION
//=============================================================================

var sigma_value = 4;
var threshold_method = "Otsu";


//=============================================================================
// MAIN WORKFLOW
//=============================================================================

// Verify that an image is open.
if (nImages() == 0) {
    exit("Error: First you need to open an image.");
}

// Retrieve the selected ROI coordinates and dimensions.
getSelectionBounds(x, y, width, height);

// Verify that an ROI has been selected.
if (width == 0) {
    exit("Error: First you need to select an area.");
}

// Ask the user to select the output directory.
output_directory = getDirectory(
    "Select the folder where the results will be saved."
);

// Stop the macro if directory selection is cancelled.
if (output_directory == "") {
    exit("The transaction has been cancelled.");
}

// Retrieve the original image name.
original_filename = getTitle();

// Remove the file extension from the original image name.
dot_position = lastIndexOf(original_filename, ".");

if (dot_position != -1) {
    filename_without_extension = substring(
        original_filename,
        0,
        dot_position
    );
} else {
    filename_without_extension = original_filename;
}

// Create a unique base filename using the ROI coordinates.
base_filename =
    filename_without_extension +
    "_ROI_x" + x +
    "_y" + y;


//=============================================================================
// STEP 1 — ROI PREPARATION
//=============================================================================

// Duplicate the selected ROI from the original image.
run("Duplicate...", "title=Fig_A_ROI");


//=============================================================================
// STEP 2 — IMAGE PREPROCESSING
//=============================================================================

// Create a Gaussian-blurred copy of the ROI.
selectWindow("Fig_A_ROI");
run("Duplicate...", "title=Fig_B_Blurred");
run("Gaussian Blur...", "sigma=" + sigma_value);

// Subtract the blurred image from the original ROI.
imageCalculator(
    "Subtract create 32-bit",
    "Fig_A_ROI",
    "Fig_B_Blurred"
);

// Prepare the subtraction result for segmentation.
selectWindow("Result of Fig_A_ROI");
run("Add...", "value=128");
run("Enhance Contrast", "saturated=0.35");
run("8-bit");
rename("Fig_C_Subtracted");


//=============================================================================
// STEP 3 — SEGMENTATION
//=============================================================================

// Create the initial binary image.
selectWindow("Fig_C_Subtracted");
run("Duplicate...", "title=Fig_D_Original_Binary");

// Apply automatic thresholding.
setAutoThreshold(threshold_method + " dark");

// Convert the thresholded image into a binary mask.
//
// This command produces white trabecular structures on a black background,
// which is the correct format for skeletonization.
run("Convert to Mask");


//=============================================================================
// STEP 4 — SKELETONIZATION
//=============================================================================

// Create a skeletonized version of the binary image.
selectWindow("Fig_D_Original_Binary");
run("Duplicate...", "title=Fig_E_Skeleton");

// Skeletonize the white trabecular structures.
run("Skeletonize");

// Prepare the binary image for fractal analysis.
//
// The Fractal Box Count command analyzes black structures.
// Therefore, the binary image must be inverted.
selectWindow("Fig_D_Original_Binary");
run("Invert");
rename("Fig_D_Binary_for_Fractal");

// Create a validation overlay by combining the original ROI
// with the white skeleton image.
imageCalculator(
    "Add create",
    "Fig_A_ROI",
    "Fig_E_Skeleton"
);

selectWindow("Result of Fig_A_ROI");
rename("Fig_F_Overlay");


//=============================================================================
// STEP 5 — FRACTAL ANALYSIS
//=============================================================================

// Perform fractal box-counting analysis on the image
// containing black trabecular structures.
selectWindow("Fig_D_Binary_for_Fractal");

run(
    "Fractal Box Count...",
    "box=2,3,4,6,8,12,16,32,64"
);

// Save the fractal analysis log.
selectWindow("Log");

saveAs(
    "Text",
    output_directory +
    base_filename +
    "_Fractal_Log.txt"
);

// Perform skeleton analysis.
//
// Analyze Skeleton requires a white skeleton on a black background.
// Therefore, inversion is not required.
selectWindow("Fig_E_Skeleton");
run("Analyze Skeleton (2D/3D)");

// Save the skeleton analysis results.
selectWindow("Results");

saveAs(
    "Results",
    output_directory +
    base_filename +
    "_Skeleton_Results.csv"
);


//=============================================================================
// STEP 6 — EXPORT RESULTS
//=============================================================================

// Export Figure A: Original ROI.
selectWindow("Fig_A_ROI");

saveAs(
    "Tiff",
    output_directory +
    base_filename +
    "_A.tif"
);

// Export Figure B: Gaussian-blurred ROI.
selectWindow("Fig_B_Blurred");

saveAs(
    "Tiff",
    output_directory +
    base_filename +
    "_B.tif"
);

// Export Figure C: Subtracted and contrast-enhanced image.
selectWindow("Fig_C_Subtracted");

saveAs(
    "Tiff",
    output_directory +
    base_filename +
    "_C.tif"
);

// Export Figure D: Binary image prepared for fractal analysis.
selectWindow("Fig_D_Binary_for_Fractal");

saveAs(
    "Tiff",
    output_directory +
    base_filename +
    "_D_Fractal.tif"
);

// Export Figure E: Skeletonized image.
selectWindow("Fig_E_Skeleton");

saveAs(
    "Tiff",
    output_directory +
    base_filename +
    "_E_Skeleton.tif"
);

// Export Figure F: Validation overlay.
selectWindow("Fig_F_Overlay");

saveAs(
    "Tiff",
    output_directory +
    base_filename +
    "_F_Overlay.tif"
);

// Close all open ImageJ windows.
run("Close All");

// Clear the Log window and display the completion message.
print("\\Clear");

print(
    "Transaction completed. The results were saved to the '" +
    output_directory +
    "' folder."
);