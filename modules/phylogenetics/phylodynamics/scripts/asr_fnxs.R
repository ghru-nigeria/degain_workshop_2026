library(phytools)
library(ape)
library(Polychrome)
library(RColorBrewer)

get_colours <- function(chars_data, seed_cols=c("#0571B0", "#FFBF00", "#CA0020")){
    set.seed(1)
    n_chars <- length(unique(chars_data))
    if(n_chars > 8) {
        colours <- setNames(
            Polychrome::createPalette(n_chars, seedcolors=seed_cols),
            sort(unique(chars_data))
        )
    } else {
        colours <- setNames(RColorBrewer::brewer.pal(8, "Set1"), 
                            sort(unique(chars_data)))
    }
    return(colours)
}

plot_ancestral_state <- function(tree, traits_named_vec, simmap_summary,
                                 colours, tree_type = 'fan', add_node_pies = F,
                                 legend_size = 0.6, tip_size=0.2, add_tip_labs=F,
                                 tip_lab_size=0.6, scale_lab_size=1.1){
    if(add_tip_labs){fsize=tip_lab_size} else {fsize=0.000000001}
    par(xpd = TRUE, oma = c(1, 1, 1, 2))
    plot(tree, colours, type=tree_type, fsize=fsize, ftype="reg", offset=.2)
    ape::axisPhylo(backward=F)
    if (add_node_pies){
        ape::nodelabels(pie = simmap_summary$ace, piecol = colours, cex = 0.3)
    }
    ape::tiplabels(pie=to.matrix(traits_named_vec, sort(unique(traits_named_vec))),
                   piecol=colours, cex=tip_size)
    if (tree_type == "fan"){
        phytools::add.simmap.legend(colors=colours, prompt=FALSE, x=0.8*par()$usr[1],
                                    y=max(nodeHeights(tree)),fsize=legend_size)
        ape::add.scale.bar(lwd=2.5, cex=scale_lab_size)
    } else if (tree_type == "phylogram") {
        phytools::add.simmap.legend(colors=colours, prompt=FALSE,
                                    # x=max(nodeHeights(tree))+1, y=Ntip(tree), 
                                    x=5, y=Ntip(tree)/1.5, 
                                    fsize=legend_size)
        ape::add.scale.bar(y=Ntip(tree)+1,x=0, lwd=2.5, cex=scale_lab_size)
    }
}

