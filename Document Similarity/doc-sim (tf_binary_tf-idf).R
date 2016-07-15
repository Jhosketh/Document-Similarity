################################################
### COSINE SIMILARITY (TF | BINARY | TF-IDF) ###
################################################

rm(list = ls())

# Constants
PATH = "C:/Users/Tifani/Documents/GitHub/Document-Similarity/Document Similarity"
CORPUS_TEST_PATH = "C:/Users/Tifani/Documents/GitHub/Document-Similarity/Document Similarity/corpus/test"
MIN_FREQ_PLOT = 50
MIN_FREQ_CLOUD = 25

# Initialization
setwd(PATH)
for (package in c('tm', 'SnowballC', 'slam', 'xlsx')) {
    if (!require(package, character.only=T, quietly=T)) {
        install.packages(package)
        library(package, character.only=T)
    }
}

# Pre-processing Corpus
corpus <- Corpus(DirSource(CORPUS_TEST_PATH))
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stemDocument)

# Creating Term Document Matrix
tdm.tf <- TermDocumentMatrix(corpus)
tdm.bin <- weightBin(tdm.tf)
tdm.tfidf <- weightTfIdf(tdm.tf, normalize = TRUE)

# Calculate Cosine Distance
cosine.dist.bin <- crossprod_simple_triplet_matrix(tdm.bin)/(sqrt(col_sums(tdm.bin^2) %*% t(col_sums(tdm.bin^2))))
cosine.dist.tf <- crossprod_simple_triplet_matrix(tdm.tf)/(sqrt(col_sums(tdm.tf^2) %*% t(col_sums(tdm.tf^2))))
cosine.dist.tfidf <- crossprod_simple_triplet_matrix(tdm.tfidf)/(sqrt(col_sums(tdm.tfidf^2) %*% t(col_sums(tdm.tfidf^2))))

# Print Result To Excel
m.vector.space <- as.matrix(tdm.tf)
m.bin <- as.matrix(cosine.dist.bin)   
m.tf <- as.matrix(cosine.dist.tf)   
m.tfidf <- as.matrix(cosine.dist.tfidf)
# (need more memory) write.xlsx(m.vector.space, file="doc_sim.xlsx", sheetName="vector_space")
write.xlsx(m.bin, file="doc_sim.xlsx", sheetName="cosine_binary")
write.xlsx(m.tf, file="doc_sim.xlsx", sheetName="cosine_tf", append=TRUE)
write.xlsx(m.tfidf, file="doc_sim.xlsx", sheetName="cosine_tf-idf", append=TRUE)

# Word Frequency
dtm <- DocumentTermMatrix(corpus)
freq <- colSums(as.matrix(dtm))
freq <- sort(colSums(as.matrix(dtm)), decreasing=TRUE)    
wordfreq <- data.frame(freq=freq)   
head(wordfreq, 10) 

# Plot Word Frequencies
library(ggplot2)
wf <- data.frame(word=names(freq), freq=freq)      
p <- ggplot(subset(wf, freq>MIN_FREQ_PLOT), aes(word, freq))  
p <- p + geom_bar(stat="identity")   
p <- p + theme(axis.text.x=element_text(angle=45, hjust=1))   
p

# Wordcloud
library(wordcloud)   
set.seed(142)   
wordcloud(names(freq), freq, min.freq=MIN_FREQ_CLOUD)
