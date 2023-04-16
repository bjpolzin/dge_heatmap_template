# Table of Contents
1. [Differential Gene Expression Heatmap](#differential-gene-expression-heatmap)
2. [Prerequisites](#prerequisites)
3. [Note on the Reference Group](#note-on-the-reference-group)
4. [Usage](#usage)
5. [Output](#output)

# Differential Gene Expression Heatmap <a name="differential-gene-expression-heatmap"></a>
This repository contains an R script for creating a customizable heatmap for comparing differential gene expression (DGE) data between two groups. The heatmap provides a visually appealing and intuitive representation of the data, making it easier to identify trends in differential expression between two groups.

## Prerequisites <a name="prerequisites"></a>
Before running the pipeline, please make sure you have the following R packages installed:

* `tidyverse`
* `dplyr`
* `ggplot2`
* `scales`
* `viridis`

## Note on the Reference Group <a name="note-on-the-reference-group"></a>
The first dataset/group listed in the script will be used as the "reference" group. It will appear on the left side of the heatmap, arranged in order of differential expression, and will be filtered based on the expression difference cutoff specified. Please keep this in mind when configuring the script and inputting your data.

## Usage <a name="usage"></a>
1. Open the main R script in your working directory.
2. Load the required libraries.
3. Configure the parameters at the beginning of the script. Set the static variables, such as the data directories, group names, column names, and labels.
4. Run the script to generate the heatmap.
5. Review your results and I hope you learn something new!

## Output <a name="output"></a>
The script generates a heatmap that looks like this:
![DGE Heatmap]
