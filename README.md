# Annotated_files_MUCS_HE

Signals are manualy trimmed, if there has more than one change point.

# How to get the change point information

There are two folders mod_sel_V1 and mod_sel_V2 and the correspoding chage point information of inside wav files are available in mod_sel_V1-annoted. csv and  mod_sel_V2-annoted.csv.

Suppose a file name from mod_sel_V1 folder is xx_yyyyy.wav, the corresponding mapping in the "mod_sel_V1-annoted. csv" csv file is mod_sel_V1/<seq_num>_<sel_id>.wav and the change point sample index can be found (Ch pt) and L1 and L2 belogngs to the language information.

corresponding text is can be found from the sel_sent, however though the sentences are full mentioned here, after fisrt change the speech from the second change is trimmed to ensure each utterance has only one language change point.
Example
 ## mod_sel_V1-annoted. csv
seq_num	sel_id	sel_seg	sel_sent	sel_st	sel_en	Ch pt	L1	L2
1	186802_FENm2lcy0NgdYIIB_0087	FENm2lcy0NgdYIIB	अधिक जानकारी के लिए कृपया हमें contact @spoken hyphen tutorial org पर लिखें	466	472	28849	H	E


This means the corresponding speech file can be found in mod_sel_V1/1_186802_FENm2lcy0NgdYIIB_0087.wav, and it change point is at sample index 28849, and before change point language in Hindi (H) and after change point language is English (E), the corresponding text in the trimmed audio is  अधिक जानकारी के लिए कृपया हमें contact @spoken hyphen tutorial org. 

The "पर लिखें" part is trimmned from the audio.

# Cite


 
