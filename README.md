FEATURE EXTRACTION CODE FOR MEDIAN FILTERING FORENSICS

This repository includes three methods for median filtering forensics in digital images. The codes are created for following publications:

1. A. Gupta and D. Singhal, “Analytical Global Median Filtering Forensics Based on Moment Histograms”, ACM transactions on Multimedia Computing, Communications and Applications (TOMM), vol. 14, no. 2, pp. 44:1–44:23, April 2018. https://doi.org/10.1145/3176650. 

2. A. Gupta and D. Singhal, “Global Median Filtering Forensic Method Based on Pearson Parameter Statistics”, IET Image Processing, vol. 13, no. 2, pp. 2045-2057, October 2019. doi: 10.1049/iet-ipr.2018.6074.

3. A. Gupta and D. Singhal, “A Simplistic Global Median Filtering Forensics Based on Frequency Domain Analysis of Image Residuals”, ACM Transactions on Multimedia Computing, Communications and Applications, vol. 15, no. 3, pp. 71:1-71:23, August 2019. 


It contains following 3 folders:

1. Feature_set_SK: The folder contains following source codes:
    
    a. features_SK.m: function to extract feature set SK for an image (only for testing purposes)
    
    b. demo.m: demo to extract training features for original and corresponding median filtered images database
    
    c. Cal_o_n_mf_ovrblk_moments.m: function called in script demo.m
    
    d. ucid00001.tif: example image from UCID database
    
2. Feature_set_κ: The folder contains following source codes:

    a. features_kappa.m: function to extract κ based feature set for an image (only for testing purposes)
    
    b. demo.m: demo to extract training features for original and corresponding median filtered images database
    
    c. kappacal.m: function called in script demo.m
    
    d. ucid00001.tif: example image from UCID database
    
3. Feature_set_GDCTF

    a. features_GDCTF.m: function to extract GDCTF feature set for an image (for both training and testing purposes)
    
    d. ucid00001.tif: example image from UCID database
    

For any queries, please contact Divya Singhal at singhal_dia@yahoo.com
    

HOW TO CITE:
If you are using this code for scholarly or academic research, please cite this papers as:

1. A. Gupta and D. Singhal, “Analytical Global Median Filtering Forensics Based on Moment Histograms”, ACM transactions on Multimedia Computing, Communications and Applications (TOMM), vol. 14, no. 2, pp. 44:1–44:23, April 2018. https://doi.org/10.1145/3176650. 

2. A. Gupta and D. Singhal, “Global Median Filtering Forensic Method Based on Pearson Parameter Statistics”, IET Image Processing, vol. 13, no. 2, pp. 2045-2057, October 2019. doi: 10.1049/iet-ipr.2018.6074.

3. A. Gupta and D. Singhal, “A Simplistic Global Median Filtering Forensics Based on Frequency Domain Analysis of Image Residuals”, ACM Transactions on Multimedia Computing, Communications and Applications, vol. 15, no. 3, pp. 71:1-71:23, August 2019.
