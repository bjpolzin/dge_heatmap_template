# Table of Contents
1. [Differential Gene Expression Heatmap](#differential-gene-expression-heatmap)
2. [Prerequisites](#prerequisites)
3. [Important Notes](#important-notes)
4. [Usage](#usage)
5. [Output](#output)

# Differential Gene Expression Heatmap <a name="differential-gene-expression-heatmap"></a>
This repository contains an R script for quickly creating a customizable heatmap for comparing differential gene expression (DGE) data between two groups. The heatmap provides a visually appealing and intuitive representation of the data, making it easier to identify trends in differential expression between two groups.

## Prerequisites <a name="prerequisites"></a>
Before running the pipeline, please make sure you have the following R packages installed:

* `tidyverse`
* `dplyr`
* `ggplot2`
* `scales`
* `viridis`

## Important Notes <a name="important-notes"></a>
In this script, the first dataset/group is designated as the "reference" group, which will appear on the left side of the heatmap. The genes will be arranged in order of differential expression, and filtered based on the specified expression difference cutoff. Keep this in mind when configuring the script and providing your data.

It's crucial that both of your DGE datasets contain identical gene IDs. The output results of the DGE method used (e.g., edgeR, DESeq2, etc.) might only include the most differentially expressed genes, rather than all analyzed genes. If the gene IDs don't match between the datasets, blank rows may appear in the heatmap. For example, filtering group 1's logFC by 0.75 might result in empty spaces on the right side of the heatmap if some of the genes are not present in group 2's dataset.

If plotting DESeq2 results, I recommend using `lfcShrink()` for better visualizations. Please see here for more details: http://bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html

## Usage <a name="usage"></a>
1. Open the main R script in your working directory.
2. Load the required libraries.
3. Configure the parameters at the beginning of the script. Set the static variables, such as the data directories, group names, column names, and labels.
4. Run the script to generate the heatmap.
5. Review your results and I hope you learn something new!

## Output <a name="output"></a>
The script generates a heatmap that looks like this:
![DGE Heatmap](heatmap_ex.png)
