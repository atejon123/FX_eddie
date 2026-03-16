library(tidyverse)
.libPaths(c(Sys.getenv('R_LIBS_USER'), .libPaths()))
# Load dataset
data_initial <- read_rds("fx_rsc_sp_map1.rds") %>% 
  filter(Thalamus > 0)

# Filter for specific brains
data_filtered <- data_initial %>% 
  filter(brain %in% c('six', 'nine', 'twelve', 'seven', 'ten', 'eleven'))

# --- Extract Metadata ---
# We extract these as vectors so they don't force the numeric data into character type
brain_labels <- as.character(data_filtered$brain)
group_labels <- as.character(data_filtered$group) # Adjust 'group' to your actual column name if different
area_names   <- colnames(data_filtered %>% select(-where(is.character)))

# --- Extract Numeric Data ---
# Transpose ONLY the numeric columns. 
# Rows will be brain areas, Columns will be individual neurons/observations.
data_only_T <- t(data_filtered %>% select(where(is.numeric)))
colnames(data_only_T) <- NULL # Clean column names for the matrix

# --- Create the Formatted List ---
unique_brains <- unique(brain_labels)

data_formated <- lapply(unique_brains, function(b) {
  # Find indices for this specific brain
  cols <- which(brain_labels == b)
  
  # Subset the numeric matrix
  mat <- data_only_T[, cols, drop = FALSE]
  
  # Assign the area names as row names
  rownames(mat) <- area_names
  return(mat)
})

saveRDS(data_formated, "formated_data.rds")