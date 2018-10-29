" 
Author: Caitlyn McColeman
Date Created: 16 Sept 2018
Last Edit: 

Visual Thinking Lab, Northwestern University
Originally Created For: Memorability  

Reviewed: 
Modified: 

INPUT: Power estimates are hardcoded. No input required.

OUTPUT: Displays the estimated sample size required for the proposed analysis. 

REQUIRES: pwr package

"

library(pwr)

# consider medium effect, four ANOVAs (one for each topic) and familywise error correction .05/4 = .0125
pwr.anova.test(k = 4, n =NULL, f = .25, sig.level = 0.125, power = 0.8)
#... where k is the four presentation types, f = effect size, sig.level is null hypothesis rejection and power is the percentage of correctly rejecting the null hypothesis

# to find a medium effect, we'll need a sample size of roughly 33

# pending pilot data about how much time is required, it'll probably be somewhere around 
(33 * 20)/60 
# = 11 hours of data collection, or 
33 * 2.2 
# $72.6 , assuming $11/hr for a 20 minute study 

