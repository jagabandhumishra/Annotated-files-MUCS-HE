# Annotated_files_MUCS_HE

Signals are manualy trimmed, if there has more than one change point.

# How to get the change point information

There are two folders: mod_sel_V1 and mod_sel_V2, each containing .wav audio files. The corresponding change point annotations for the audio files are provided in the CSV files mod_sel_V1-annoted.csv and mod_sel_V2-annoted.csv, respectively.

Each audio file in the mod_sel_V1 folder is named in the format xx_yyyyy.wav. In the annotation CSV file, these files are referred to as mod_sel_V1/<seq_num>_<sel_id>.wav. The CSV includes the change point sample index (Ch pt), along with L1 and L2, which represent the languages spoken before and after the change point.

The corresponding transcript for each audio file is available in the sel_sent column of the CSV. Although the full sentence is provided, the audio is trimmed after the second language change to ensure that each utterance contains only a single language transition.

# Example
 ## mod_sel_V1-annoted. csv
seq_num	sel_id	sel_seg	sel_sent	sel_st	sel_en	Ch pt	L1	L2
1	186802_FENm2lcy0NgdYIIB_0087	FENm2lcy0NgdYIIB	अधिक जानकारी के लिए कृपया हमें contact @spoken hyphen tutorial org पर लिखें	466	472	28849	H	E


This means the corresponding speech file can be found in mod_sel_V1/1_186802_FENm2lcy0NgdYIIB_0087.wav, and it change point is at sample index 28849, and before change point language in Hindi (H) and after change point language is English (E), the corresponding text in the trimmed audio is  अधिक जानकारी के लिए कृपया हमें contact @spoken hyphen tutorial org. 

The "पर लिखें" part is trimmned from the audio.

# Cite

@article{MISHRA2024104678,
title = {Generative attention based framework for implicit language change detection},
journal = {Digital Signal Processing},
volume = {154},
pages = {104678},
year = {2024},
issn = {1051-2004},
doi = {https://doi.org/10.1016/j.dsp.2024.104678},
url = {https://www.sciencedirect.com/science/article/pii/S1051200424003038},
author = {Jagabandhu Mishra and S.R. {Mahadeva Prasanna}},
keywords = {Spoken language change detection, Generative adversarial network (GAN), Attention, Speaker change detection},
abstract = {Spoken language change detection (LCD) refers to detecting language switching points in a multilingual speech signal. Most approaches in literature use the explicit framework that requires the modeling of intermediate phonemes and Senones to distinguish language. However, such techniques are limited when used with resource scare/ zero resource languages. Hence as an alternative, this study explores implicit frameworks to perform LCD. The focus of this work is to detect language change when a single speaker is speaking two languages. In this direction, a subjective study is performed to analyze the method humans adapt to discriminate languages. The outcome of the subjective study suggests humans require more neighborhood duration to detect language change. The initial observation suggests, that detecting language change is challenging using the baseline implicit unsupervised distance-based approach. Inspired by human cognition, prior language knowledge is integrated into the computational framework through the Gaussian mixture model and universal background model (GMM-UBM), temporal information via attention, and pattern storage using the Generative adversarial network (GAN) to enhance language discrimination. The experimental results on the Microsoft code-switched (MSCS) dataset show, compared to the unsupervised distance-based approach, the performance of the proposed LCD relatively improved by 19.3%, 47.3%, and 50.7% using the GMM-UBM, attention, and GAN-attention based framework, respectively.}
}


 
