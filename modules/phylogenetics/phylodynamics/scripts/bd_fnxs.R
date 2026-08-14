library(tidyverse)
library(BactDating)
library(ape)
library(phangorn)

bd_to_beast_tree <- function(bd_mcmc, dates_bd, show_tree=F){
    beast_tree <- BactDating::as.treedata.resBactDating(bd_mcmc)
    # Get data
    bestroot <- as.numeric(names(sort(table(
        bd_mcmc$record[floor(nrow(bd_mcmc$record)/2):nrow(bd_mcmc$record),
                       "root"]), decreasing = T)[1]))
    # Rows with post-burn-in samples where "root" is bestroot
    bestrows <- intersect(floor(nrow(bd_mcmc$record)/2):nrow(bd_mcmc$record), 
                          which(bd_mcmc$record[, "root"] == bestroot))
    # Calculate mean node dates using best rows
    meanRec <- colMeans(bd_mcmc$record[bestrows, , drop = F])
    node_dates <- bd_mcmc$CI %>% 
        tibble::as_tibble(rownames = "node") %>% 
        dplyr::rename("date_lower" = "V1", "date_upper" = "V2") %>% 
        dplyr::mutate(date = unname(meanRec[1:nrow(bd_mcmc$CI)]))
    # Rejoin to tree data
    tree_data <- tibble::as_tibble(as.data.frame(beast_tree[[2]])) %>% 
        dplyr::mutate(node = trimws(node)) %>% 
        dplyr::left_join(node_dates, by = "node")
    # Make final beast-ish tree file
    beast_tree <- methods::new('treedata', phylo=beast_tree[[1]], data=tree_data)
    
    # Plot tree for sanity check
    p <- ggtree::ggtree(beast_tree, mrsd=lubridate::date_decimal(max(dates_bd, na.rm = T))) +
        ggtree::geom_range(range='length_0.95_HPD', color='red', alpha=.6, size=2) +
        # ggtree::geom_text(aes(label=node), size=2, hjust=1.2, vjust=-0.2) +
        ggtree::theme_tree2()
    if(show_tree) {print(p)}
    
    return(beast_tree)
}


