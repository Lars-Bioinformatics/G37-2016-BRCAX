#!/usr/bin/env Rscript
library(ggplot2)

args = commandArgs(trailingOnly=TRUE)
infile=args[1]

dt = read.table(file = infile, sep = "\t", header = F)
names(dt) = c("chr", "start", "end", "copynumber")

p = ggplot(data = dt, aes(x=start, y=copynumber, fill = factor(chr))) +
    geom_point(aes(colour = factor(chr))) +
    facet_grid(~chr, switch = 'x') +
    #theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1), panel.spacing = unit(0.1, "lines")) +
    theme(axis.text.x = element_blank(),
          axis.ticks.x = element_blank(),
          panel.spacing = unit(0, "lines")) +
    #scale_fill_discrete(name="chromosomes", breaks = factor(dt$chr), labels=factor(dt$chr)) +
    #guides(fill=guide_legend(title="chromosomes")) +
    xlab("Physical postion") +
    labs(colour = "chromosomes", fill = "chromosomes")

ggsave(plot = p, filename = paste0(infile, ".plot.png"), width = 14, height= 8)
