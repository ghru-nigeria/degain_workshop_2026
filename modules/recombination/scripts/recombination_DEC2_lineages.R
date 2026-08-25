# Install reguired packagesRun once
# install.packages(c("tidyverse", "janitor", "ggpubr",  "patchwork"))

library(tidyverse)
library(janitor)
library(ggpubr)      
library(patchwork)   

#windows
#setwd("C:/path/to/degain/clusters/")

setwd("/Users/oyi05/Desktop/degain/")

# Import each lineage file (tab-separated despite .csv) 
c12 <- read_tsv("cluster12/gubbins.per_branch_statistics.csv", show_col_types = FALSE) %>%
  clean_names() %>% filter(node != "Reference") %>% mutate(lineage = "12")

c17 <- read_tsv("cluster17/gubbins.per_branch_statistics.csv", show_col_types = FALSE) %>%
  clean_names() %>% filter(node != "Reference") %>% mutate(lineage = "17")

c20 <- read_tsv("cluster20/gubbins.per_branch_statistics.csv", show_col_types = FALSE) %>%
  clean_names() %>% filter(node != "Reference") %>% mutate(lineage = "20")

dat <- bind_rows(c12, c17, c20) %>%
  mutate(lineage = factor(lineage, levels = c("12", "17", "20"))) %>%
  rename_with(~ gsub("_sn_ps", "_snps", .x))


pal <- c("12" = "#E69F00", "17" = "#009E73", "20" = "#56B4E9")  # one colour per lineage

my_comps <- list(c("12", "17"), c("12", "20"), c("17", "20"))    # lineage pairs to compare

# Fig 1.: Show SNPs inside vs outside recombinations
inout <- dat %>%
  transmute(lineage,
            In  = number_of_snps_inside_recombinations,
            Out = number_of_snps_outside_recombinations) %>%
  pivot_longer(c(In, Out), names_to = "location", values_to = "snps") %>%
  mutate(location = factor(location, levels = c("In", "Out")))

fig1 <- ggplot(inout, aes(location, snps)) +
  geom_violin(aes(fill = lineage), colour = "grey40", alpha = 0.5, scale = "width") +
  geom_jitter(aes(colour = lineage), width = 0.12, size = 0.6, alpha = 0.5) +
  geom_boxplot(width = 0.12, fill = "white", outlier.shape = NA) +
  stat_summary(fun = mean, geom = "point", colour = "darkred", size = 1.8) +
  stat_compare_means(comparisons = list(c("In", "Out")), method = "wilcox.test",
                     label = "p.signif", size = 3) +   
  facet_wrap(~ lineage, nrow = 1, scales = "free_y") +
  scale_fill_manual(values = pal) + scale_colour_manual(values = pal) +
  labs(x = NULL, y = "SNPs") +
  theme_classic(base_size = 11) + theme(legend.position = "none")

fig1

# Fig 2.: Number of recombination blocks 
fig2 <- ggplot(dat, aes(lineage, number_of_recombination_blocks)) +
  geom_violin(aes(fill = lineage), colour = "grey40", alpha = 0.5, scale = "width") +
  geom_jitter(aes(colour = lineage), width = 0.12, size = 0.7, alpha = 0.5) +
  geom_boxplot(width = 0.12, fill = "white", outlier.shape = NA) +
  stat_summary(fun = mean, geom = "point", colour = "darkred", size = 2) +
  stat_compare_means(comparisons = my_comps, method = "wilcox.test",
                     label = "p.signif", hide.ns = F, tip.length = 0.01, size = 3) +
  scale_fill_manual(values = pal) + scale_colour_manual(values = pal) +
  scale_y_continuous(expand = expansion(mult = c(0.02, 0.15))) +
  labs(x = "BAPS", y = "Number of\nRecombination Blocks") +
  theme_classic(base_size = 11) + theme(legend.position = "none")

fig2

# Fig 3.: Bases in recombination (x10^5) 
fig3 <- ggplot(dat, aes(lineage, bases_in_recombinations_excluding_gaps / 1e5)) +
  geom_violin(aes(fill = lineage), colour = "grey40", alpha = 0.5, scale = "width") +
  geom_jitter(aes(colour = lineage), width = 0.12, size = 0.7, alpha = 0.5) +
  geom_boxplot(width = 0.12, fill = "white", outlier.shape = NA) +
  stat_summary(fun = mean, geom = "point", colour = "darkred", size = 2) +
  stat_compare_means(comparisons = my_comps, method = "wilcox.test",
                     label = "p.signif", hide.ns = F, tip.length = 0.01, size = 3) +
  scale_fill_manual(values = pal) + scale_colour_manual(values = pal) +
  scale_y_continuous(expand = expansion(mult = c(0.02, 0.15))) +
  labs(x = "BAPS", y = "Bases in Recombination\n(bps x10^5)") +
  theme_classic(base_size = 11) + theme(legend.position = "none")

fig3

# Fig 4.: Cumulative bases in recombination (x10^5) 
fig4 <- ggplot(dat, aes(lineage, cumulative_bases_in_recombinations_excluding_gaps / 1e5)) +
  geom_violin(aes(fill = lineage), colour = "grey40", alpha = 0.5, scale = "width") +
  geom_jitter(aes(colour = lineage), width = 0.12, size = 0.7, alpha = 0.5) +
  geom_boxplot(width = 0.12, fill = "white", outlier.shape = NA) +
  stat_summary(fun = mean, geom = "point", colour = "darkred", size = 2) +
  stat_compare_means(comparisons = my_comps, method = "wilcox.test",
                     label = "p.signif", hide.ns = F, tip.length = 0.01, size = 3) +
  scale_fill_manual(values = pal) + scale_colour_manual(values = pal) +
  scale_y_continuous(expand = expansion(mult = c(0.02, 0.15))) +
  labs(x = "BAPS", y = "Cumulative bases in\nRecombination (bps x10^5)") +
  theme_classic(base_size = 11) + theme(legend.position = "none")

fig4

# fig4 5.: Panel E: r/m 
fig5 <- ggplot(dat, aes(lineage, r_m)) +
  geom_violin(aes(fill = lineage), colour = "grey40", alpha = 0.5, scale = "width") +
  geom_jitter(aes(colour = lineage), width = 0.12, size = 0.7, alpha = 0.5) +
  geom_boxplot(width = 0.12, fill = "white", outlier.shape = NA) +
  stat_summary(fun = mean, geom = "point", colour = "darkred", size = 2) +
  stat_compare_means(comparisons = my_comps, method = "wilcox.test",
                     label = "p.signif", hide.ns = F, tip.length = 0.01, size = 3) +
  scale_fill_manual(values = pal) + scale_colour_manual(values = pal) +
  scale_y_continuous(expand = expansion(mult = c(0.02, 0.15))) +
  labs(x = "BAPS", y = "r/m") +
  theme_classic(base_size = 11) + theme(legend.position = "none")

fig5


dat %>% group_by(lineage) %>% summarise(mean_r_m = mean(r_m, na.rm = TRUE))

dat %>% group_by(lineage) %>% summarise(mean_r_m = mean(rho_theta, na.rm = TRUE))




# Fig 6.: rho/theta 
fig6 <- ggplot(dat, aes(lineage, rho_theta)) +
  geom_violin(aes(fill = lineage), colour = "grey40", alpha = 0.5, scale = "width") +
  geom_jitter(aes(colour = lineage), width = 0.12, size = 0.7, alpha = 0.5) +
  geom_boxplot(width = 0.12, fill = "white", outlier.shape = NA) +
  stat_summary(fun = mean, geom = "point", colour = "darkred", size = 2) +
  stat_compare_means(comparisons = my_comps, method = "wilcox.test",
                     label = "p.signif", hide.ns = F, tip.length = 0.01, size = 3) +
  scale_fill_manual(values = pal) + scale_colour_manual(values = pal) +
  scale_y_continuous(expand = expansion(mult = c(0.02, 0.15))) +
  labs(x = "BAPS", y = "rho/theta") +
  theme_classic(base_size = 11) + theme(legend.position = "none")

fig6

# All figures in one
figure <- fig1 / (fig2 | fig3) / (fig4 | fig5) / fig6 +
  plot_annotation(tag_levels = "A")

ggsave("recombination_figure.png", figure, width = 9, height = 12, dpi = 300)
print(figure)
