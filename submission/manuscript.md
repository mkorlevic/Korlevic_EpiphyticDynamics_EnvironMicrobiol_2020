---
title: "**Dynamics of Epiphytic Microbial Communities on Marine Macrophyte Surfaces**"
output:
  pdf_document:
    keep_tex: true
    includes:
      in_header: header.tex
fontsize: 12pt
geometry: margin=1.0in
csl: citation_style.csl #Get themes at https://github.com/citation-style-language/styles
bibliography: references.bib
---



\vspace{80mm}

^1$\dagger$^

\vspace{40mm}

$\dagger$ To whom correspondence should be addressed: marino.korlevic@irb.hr


1\. Ruđer Bošković Institute, Center for Marine Research, G. Paliaga 5, Rovinj, Croatia

2\. University of Vienna, Department of Limnology and Bio-Oceanography, Althanstraße 14, Vienna, Austria
\newpage
\linenumbers
\sisetup{mode=text}
\setlength\parindent{24pt}

## Abstract


\newpage
## Introduction

\newpage
## Materials and Methods
### Sampling
Leaves of *Cymodocea nodosa* were sampled in a *Cymodocea nodosa* meadow in the Bay of Saline (45°7´5˝N, 13°37´20˝E) and in a *Cymodocea nodosa* meadow invaded by *Caulerpa cylindracea* in the proximity of the village of Funtana (45°10´39˝N, 13°35´42˝E). Thalli of *Caulerpa cylindracea* were sampled in the same *Cymodocea nodosa* invaded meadow in Funtana and on a locality of only *Caulerpa cylindracea* located in the proximity of the invaded meadow. Leaves and thalli were collected on the same day in two contrasting seasons, on 4 December 2017 and 18 June 2018. During spring 2018 the *Cymodocea nodosa* meadow in the Bay of Saline decayed to an extent that no leaves could be retrieved (Najdek *et al.*, unpublished data). Leaves and thalli were collected by diving and transported to the laboratory in containers placed on ice and filled with site seawater. Upon arrival to the laboratory, *Cymodocea nodosa* leaves were cut into sections of 1 -- 2 \si{\cm}, while *Caulerpa cylindracea* thalli were cut into 5 -- 8 \si{\cm} long sections. Leaves and thalli were washed three times with sterile artificial seawater (ASW) to remove loosely attached microbial cells.

### DNA Isolation
The DNA was isolated according to the protocol for isolation from filters described in @Massana1997. This protocol was modified and adapted for DNA isolation from microbial communities from macrophyte surfaces as described below. 5 \si{\ml} of lysis buffer (40 \si{\milli\Molar} EDTA, 50 \si{\milli\Molar} Tris-HCl, 0.75 \si{\Molar} sucrose; pH 8.3) was added to 1 \si{\g} wet weight of leaves or \si{\g} wet-weight of thalli. Lysozyme was added (final concentration 1 \si{\mg\per\ml}) and the mixture was incubated at 37 \si{\degreeCelsius} for 30 \si{\minute}. Subsequently, proteinase K (final concentration 0.5 \si{\mg\per\ml}) and SDS (final concentration 1 \si{\percent}) were added and the samples were incubated at 55 \si{\degreeCelsius} for 2 \si{\hour}. Following the incubation, tubes were vortexed for 10 \si{\minute} and the mixture containing lyzed epiphytic cells was separated from host leaves or thalli by transferring the solution into a clean tube. The lysate was extracted twice with a mixture of phenol:chloroform:isoamyl alcohol (25:24:1; pH 8) and once with chloroform:isoamyl alcohol (24:1). After each organic solvent mixture addition tubes were slightly vortexed and centrifuged at 4,500 × g for 10 \si{\minute}. Following each centrifugation aqueous phases were retrieved. After the final extraction 1/10 of chilled 3 \si{\Molar} sodium acetate (pH 5.2) was added. DNA was precipitated by adding 1 volume of chilled isopropanol, incubating the mixtures overnight at \num{-20} °C and centrifuging at 16,000 × g and 4 \si{\degreeCelsius} for 20 \si{\minute}. The pellet was washed twice with 1 \si{\ml} of chilled isopropanol and centrifuged after each washing step at 20,000 × g and 4 \si{\degreeCelsius} for 10 \si{\minute}. After the first washing step duplicate pellets form the same sample were pooled and transferred to a clean 1.5 \si{\ml} tube. The dried pellet was resuspended in 100 \si{\ul} of deionized water.

### Illumina 16S rRNA Sequencing
An aliquot of isolated DNA was treated with RNase A (final concentration 200 \si{\ug\per\ml}) for 2 \si{\hour} at 37 \si{\degreeCelsius}. The DNA concentration was determined using the Quant-iT PicoGreen dsDNA Assay Kit (Invitrogen, USA) according to the manufacturer’s instructions and diluted to 1 \si{\ng\per\ul}. The V4 region of the 16S rRNA gene was amplified using a two-step PCR procedure. In the first PCR the 515F (5'-GTGYCAGCMGCCGCGGTAA-3') and 806R (5'-GGACTACNVGGGTWTCTAAT-3') primers from the Earth Microbiome Project (http://press.igsb.anl.gov/earthmicrobiome/protocols-and-standards/16s/) were used to amplify the target region [@Caporaso2012; @Apprill2015; @Parada2016]. These primers contained on their 5' end a tagged sequence. Each sample was amplified in four parallel 25 \si{\ul} reactions of which each contained: 1 × Q5 Reaction Buffer , 0.2 \si{\milli\Molar} of dNTPmix, 0.7 \si{\mg\per\ml} BSA (Bovine Serum Albumin), 0.2 \si{\micro\Molar} of forward and reverse primers, 0.5 U of Q5 High-Fidelity DNA Polymerase (New England Biolabs, USA) and 5 \si{\ng} of DNA template. Cycling conditions were: initial denaturation at 94 \si{\degreeCelsius} for 3 \si{\minute}, 20 cycles of denaturation at 94 \si{\degreeCelsius} for 45 \si{\s}, annealing at 50 \si{\degreeCelsius} for 60 \si{\s} and elongation at 72 \si{\degreeCelsius} for 90 \si{\s}, finalized by an elongation step at 72 \si{\degreeCelsius} for 10 \si{\minute}. The four parallel reactions volumes were pooled and PCR products were purified using the GeneJET PCR Purification Kit (Thermo Fisher Scientific, USA) according to the manufacturer's instructions and following the protocol that included isopropanol addition for better small DNA fragment yield. The column was eluted in 30 \si{\ul} of deionized water. Purified PCR products were sent for Illumina MiSeq sequencing (2 × 250 bp) at IMGM Laboratories, Martinsried, Germany. Before sequencing, at IMGM the second PCR amplification of the two-step PCR procedure was performed using primers targeting the tagged region incorporated in the first PCR. In addition, these primers contained adapter and sample-specific index sequences. The second PCR was carried out for 8 cycles. Beside samples, a positive and negative control were sequenced. A negative control was comprised of four parallel PCR reactions without DNA template, while for a positive control a mock community composed of evenly mixed DNA material originating from 20 bacterial strains (ATCC MSA-1002, ATCC, USA) was used. The sequences obtained in this study have been submitted to the European Nucleotide Archive (ENA) under accession numbers **TO BE ADDED LATER!**.

### Sequence Analysis

Obtained sequences were analyzed on the computer cluster Isabella (University Computing Center, University of Zagreb) using mothur (version 1.43.0) [@Schloss2009] according to the MiSeq Standard Operating Procedure (MiSeq SOP; https://mothur.org/wiki/MiSeq_SOP) [@Kozich2013] and recommendations given from the Riffomonas project to enhance data reproducibility (http://www.riffomonas.org/). For alignment and classification of sequences the SILVA SSU Ref NR 99 database (release 132; http://www.arb-silva.de) was used [@Quast2013; @Yilmaz2014]. Sequences classified as chloroplasts by mothur were exported, aligned using SILVA incremental aligner (SINA, version 1.6.0) [@Pruesse2012] against the same SILVA SSU Ref NR 99 database (release 132) and imported into ARB (version 6.0.6) [@Ludwig2004] for further phylogenetic analysis using the same database. Reference sequences close to imported ones were selected and used to calculate a phylogenetic tree using the Maximum Likelihood algorithm RAxML (version 7.0.3) with 1000 tree replicates [@Stamatakis2006]. Imported partial chloroplast sequences were added to the tree using the maximum parsimony criteria and not allowing changes to tree topology. Pipeline data processing and visualization was done using R (version 3.6.0) [@RCoreTeam2019], package tidyverse (version 1.2.1) [@Wickham2019] and multiple other packages [@Xie2014; @Xie2015; @Xie2019a; @Xie2019; @Zhu2019; @Allaire2019; @Xie2018]. The detailed analysis procedure including the R Markdown file for this paper are available as a GitHub repository (**TO BE ADDED LATER!**). Based on the ATCC MSA-1002 mock community included in the analysis a sequencing error rate of 0.01 \si{\percent} was determined, which is in line with previously reported values for next-generation sequencing data [@Kozich2013; @Schloss2016]. In addition, the negative control processed together with the samples yielded only 2 sequences after sequence quality curation.

### Protein Isolation
Proteins were isolated according to the protocol for isolation from soil described in @Chourey2010 and modified by @Hultman2015. These protocols were further modified and adapted for protein isolation from microbial communities form macrophyte surfaces as described below. 20 \si{\ml} of protein extraction buffer (4 \si{\percent} SDS, 100 \si{\milli\Molar} Tris-HCl [pH 8.0]) was added to 5 \si{\g} wet weight of leaves or 10 \si{\g} wet weight of thalli. The mixture was incubated in boiling water for 5 \si{\minute}, vortexed for 10 \si{\minute} and incubated again in boiling water for 5 \si{\minute}. After a brief vortex the lysate was transferred to a clean tube separating the host leaves or thalli from the mixture containing lyzed epiphytic cells. Dithiothreitol (DTT; final concentration 24 \si{\milli\Molar}) was added and proteins were precipitated with chilled 100 \si{\percent} trichloroacetic acid (TCA; final concentration 20 \si{\percent}) overnight at \num{-20} °C. Precipitated proteins were centrifuged at 10,000 × g and 4 \si{\degreeCelsius} for 40 \si{\minute}. The obtained protein pellet was washed three times with chilled acetone. During the first washing step the pellet was transferred to a clean 1.5 \si{\ml} tube. After each washing step samples were centrifuged at 20,000 × g and 4 \si{\degreeCelsius} for 5 \si{\minute}. Dried pellets were stored at \num{-80} °C until further analysis.

### Metaproteomics
Isolated proteins were whole trypsin digested using the FASP (filter-aided sample preparation) Protein Digestion Kit (Expedeon, UK) according to the manufacturer's instructions [@Wisniewski2009] with small modifications. Before loading the solution to the column, protein pellets were solubilized in a urea sample buffer included in the kit amended with DTT (final concentration 100 \si{\milli\Molar}) for 45 \si{\minute} at room temperature and centrifuged at 20,000 × g for 2 -- 5 \si{\minute} at room temperature to remove larger particles. The first washing step after protein solution loading was repeated twice. In addition, centrifugation steps were prolonged if the column was clogged. Trypsin digestion was performed on column filters at 37 \si{\degreeCelsius} overnight for 18 \si{\hour}. The final filtrate containing digested proteins was acidified with 1 \si{\percent} (final concentration) trifluoroacetic acid, freezed at \num{-80} \si{\degreeCelsius} for 15 \si{\minute}, lyophilized and sent to the Vienna Metabolomics Center (University of Vienna) for metaproteomic analysis. Peptides were resuspended in 1 \si{\percent} (final concentration) trifluoroacetic acid, desalted using the Pierce C18 Tips (Thermo Fisher Scientific, USA) according to the manufacturer's instructions and sequenced on a Q Exactive Hybrid Quadrupole-Orbitrap Mass Spectrometer (Thermo Fisher Scientific, USA). Obtained MS/MS spectra were searched against a protein database from metagenomic assembly published in @Burke2011a using SEQUEST-HIT engines and validated with Percolator in Proteome Discoverer 2.1 (Thermo Fisher Scientific, USA). The target-decoy approach was used to reduce the probability of false peptide identification. Results whose false discovery rate at the peptide level was \SI{< 1}{\percent} were kept. For protein identification a minimum of of two peptides and one unique peptide were required. For protein quantification, a chromatographic peak area-based free quantitative method was applied.

### Confocal Microscopy
Host leaves and thalli from DNA and protein isolation steps were washed seven times in deionized water and fixed with formaldehyde (final concentration ~ 3 \si{\percent}). In addition, nontreated leaves and thalli, washed three times in ASW to remove loosely attached microbial cells, were fixed in the same concentration of formaldehyde and used as a positive control. For long therm storage, fixed leaves and thalli were immersed in a mixture of phosphate-buffered saline (PBS) and ethanol (1:1) and stored at \num{-20} \si{\degreeCelsius}. Treated and untreated leaves and thalli segments were stained in a 2 × solution of SYBR Green I and examined under a Leica TCS SP8 X FLIM confocal microscope (Leica Microsystems, Germany).

## Results

## Discussion

## Acknowledgements

\newpage
## References
<div id="refs"></div>

\newpage 
\setlength\parindent{0pt}

## Figure Captions
**\autoref{community}.** \nameref{community}

\newpage
## Figures
\newpage
\begin{figure}[ht]

{\centering \includegraphics[width=1\linewidth]{../results/figures/community_barplot_phylum} 

}

\caption{Taxonomic classification and relative contribution of the most abundant bacterial sequences.\label{community}}\label{fig:unnamed-chunk-2}
\end{figure}