# Load required libraries
library(tidyverse)
library(ggplot2)
library(scales)
library(viridis)

# NOTE: The first dataset/group listed in this template will be used as the "reference" group.
# It will appear on the left side of the heatmap, arranged in order of differential expression,
# and will be filtered based on the expression difference cutoff specified below.

# Define data directories for differential gene expression (DGE) results
# Ensure both DGE dataframes contain exactly the same genes analyzed
dge_1_dir <- "" # Directory for the first dataset
dge_2_dir <- "" # Directory for the second dataset

# Name of groups being compared
dge_1_group <- "" # Name of the first group
dge_2_group <- "" # Name of the second group

# Define column names and group labels
expr_diff_col <- "" # Column name for the expression difference measure (e.g., Log2FC)
gene_id_col <- ""   # Column name for individual gene IDs

# Define minimum absolute value of expression difference you want visualized on the heatmap
expr_diff_cutoff <- # Minimum absolute value (e.g., 0.7)
  

# Define overall labels for heatmap
x_axis_label <- "" # X-axis label; use empty quotes for no label
y_axis_label <- "" # Y-axis label; use empty quotes for no label

#############################################################
# Template below is based on static variables defined above #
#############################################################

# Read in DGE data
dge_1_df <- readr::read_csv(dge_1_dir)
dge_2_df <- readr::read_csv(dge_2_dir)

# Select columns of interest and add group identifiers
interest_cols <- c(gene_id_col, expr_diff_col)
dge_1_df_tbc <- dge_1_df %>%
  dplyr::select(all_of(interest_cols)) %>%
  dplyr::mutate(group_id = dge_1_group)
dge_2_df_tbc <- dge_2_df %>%
  dplyr::select(all_of(interest_cols)) %>%
  dplyr::mutate(group_id = dge_2_group)

# Combine DGE results and filter out NAs
dge_comb_df <- rbind(dge_1_df_tbc, dge_2_df_tbc) %>%
  dplyr::filter(!is.na(.[[expr_diff_col]]))

# Arrange by category, calculate absolute expression difference, and filter out by threshold of cutoff
dge_arr_df <- dge_comb_df %>%
  dplyr::arrange(group_id, .[[expr_diff_col]]) %>%
  dplyr::mutate(abs_expr_diff = abs(.[[expr_diff_col]])) %>%
  dplyr::filter(group_id == dge_1_group & abs_expr_diff >= expr_diff_cutoff)

# Extract selected gene IDs
select_gene_ids <- dge_arr_df$gene_id

# Filter combined DGE data by selected gene IDs and update gene_id_ordered
dge_hm_df <- dge_comb_df %>%
  dplyr::filter(gene_id %in% select_gene_ids) %>%
  dplyr::mutate(gene_id_ordered = factor(gene_id, levels = unique(as.character(dge_arr_df[[gene_id_col]])))) %>%
  dplyr::mutate(group_id_fac = factor(group_id, levels = c(dge_1_group, dge_2_group)))

# Create heatmap
heat_map <- dge_hm_df %>% 
  ggplot(aes(group_id_fac, gene_id_ordered, fill = .data[[expr_diff_col]])) +
  geom_raster() +
  xlab(x_axis_label) +
  ylab(y_axis_label) +
  scale_fill_viridis(option = "D", 
                     guide = guide_colorbar(barheight = unit(5.62, "inch"), 
                                            direction = "vertical", title = NULL, 
                                            label.theme = element_text(angle = 90))) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 11),
        axis.text.y = element_blank(), axis.ticks.y = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        legend.position = "right",
        legend.margin = margin(t = 0, r = 0, b = 0, l = 0))

# Display heatmap
heat_map
             
