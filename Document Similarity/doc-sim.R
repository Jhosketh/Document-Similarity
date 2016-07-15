# Constant
PATH = "C:/Users/Tifani/Documents/GitHub/Document-Similarity/Document Similarity"
CORPUS_PATH = "C:/Users/Tifani/Documents/GitHub/Document-Similarity/Document Similarity/corpus"
CORPUS_TEST_PATH = "C:/Users/Tifani/Documents/GitHub/Document-Similarity/Document Similarity/corpus/test"

# Preliminary Steps
Sys.setenv(NOAWT=TRUE)
Needed <- c("tm", "SnowballC", "RColorBrewer", "ggplot2", "wordcloud", "biclust", "cluster", "igraph", "fpc")
install.packages(Needed, dependencies=TRUE) 
require("tm")
require("SnowballC")
library("wordcloud")
library(slam)

# Load Corpus to Workspace
corpus <- Corpus(DirSource(CORPUS_TEST_PATH))

# Cleaning Corpus (getTransformations for info)
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stemDocument)

# Investigate Text
tdm <- TermDocumentMatrix(corpus)
dtm <- DocumentTermMatrix(corpus)   
freq <- colSums(as.matrix(dtm)) 
freq <- sort(freq, decreasing=TRUE)  

# Dendogram
df <- as.data.frame(inspect(tdm))
df.scale <- scale(df)
d <- dist(df.scale, method="euclidean")
fit <- hclust(d, method="ward.D2")
plot(fit)

# Wordcloud
words <- names(freq)
wordcloud(words[1:100], freq[1:100])

# Export to Excel
m <- as.matrix(dtm)   
dim(m)   
write.csv(m, file="dtm.csv") 

# Removing Sparse Items
dtms <- removeSparseTerms(dtm, 0.1) 

# Organize by Frequency
freq <- colSums(as.matrix(dtm))   
length(freq)
ord <- order(freq)   
freq[head(ord)]
dtms <- removeSparseTerms(dtm, 0.1)

# Cosine Similarity
Sys.setenv(NOAWT=TRUE)
require("tm")
require("SnowballC")
library(slam)

corpus <- Corpus(DirSource(CORPUS_TEST_PATH))
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stemDocument)
tdm <- TermDocumentMatrix(corpus)

cosine_dist_mat_v1 <- crossprod_simple_triplet_matrix(tdm)/(sqrt(col_sums(tdm^2) %*% t(col_sums(tdm^2))))
m <- as.matrix(cosine_dist_mat_v1)   
dim(cosine_dist_mat_v1)   
write.csv(m, file="cosine_dist_mat_v1.csv") 

mattdm <- as.matrix(tdm)
cosine_dist_mat_v2 <- cosine(mattdm, y = NULL)
m <- as.matrix(cosine_dist_mat_v2)   
dim(cosine_dist_mat_v2)   
write.csv(m, file="cosine_dist_mat_v2.csv") 

m <- as.matrix(cosine_dist_mat)   
dim(cosine_dist_mat)   
write.csv(m, file="cosine_dist_mat.csv") 
cosine_dist_mat

# Cosine Similarity (another)
cosine_dist_mat_v2cosine(mattdm, y = NULL)

#############################################

# COSINE SIMILARITY
PATH = "C:/Users/Tifani/Documents/GitHub/Document-Similarity/Document Similarity"
CORPUS_TEST_PATH = "C:/Users/Tifani/Documents/GitHub/Document-Similarity/Document Similarity/corpus/test"

setwd(PATH)
for (package in c('tm', 'SnowballC', 'slam', 'xlsx')) {
    if (!require(package, character.only=T, quietly=T)) {
        install.packages(package)
        library(package, character.only=T)
    }
}

corpus <- Corpus(DirSource(CORPUS_TEST_PATH))
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stemDocument)

tdm.tf <- TermDocumentMatrix(corpus)
tdm.bin <- weightBin(tdm.tf)
tdm.tfidf <- weightTfIdf(tdm.tf, normalize = TRUE)

cosine.dist.bin <- crossprod_simple_triplet_matrix(tdm.bin)/(sqrt(col_sums(tdm.bin^2) %*% t(col_sums(tdm.bin^2))))
cosine.dist.tf <- crossprod_simple_triplet_matrix(tdm.tf)/(sqrt(col_sums(tdm.tf^2) %*% t(col_sums(tdm.tf^2))))
cosine.dist.tfidf <- crossprod_simple_triplet_matrix(tdm.tfidf)/(sqrt(col_sums(tdm.tfidf^2) %*% t(col_sums(tdm.tfidf^2))))

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
# dtms <- removeSparseTerms(dtm, 0.1)    
freq <- colSums(as.matrix(dtm))
freq <- sort(colSums(as.matrix(dtm)), decreasing=TRUE)   
head(freq, 14)   
findFreqTerms(dtm, lowfreq=50)
wf <- data.frame(word=names(freq), freq=freq)   
head(wf)  

# Plot Word Frequencies
library(ggplot2)   
p <- ggplot(subset(wf, freq>50), aes(word, freq))  # change freq  
p <- p + geom_bar(stat="identity")   
p <- p + theme(axis.text.x=element_text(angle=45, hjust=1))   
p

# Wordcloud
library(wordcloud)   
set.seed(142)   
wordcloud(names(freq), freq, min.freq=25)



tdn

m <- as.matrix(cosine_dist_mat_v1)   
dim(cosine_dist_mat_v1)   
write.csv(m, file="cosine_dist_mat_v1.csv") 

mattdm <- as.matrix(tdm)
cosine_dist_mat_v2 <- cosine(mattdm, y = NULL)
m <- as.matrix(cosine_dist_mat_v2)   
dim(cosine_dist_mat_v2)   
write.csv(m, file="cosine_dist_mat_v2.csv") 

m <- as.matrix(cosine_dist_mat)   
dim(cosine_dist_mat)   
write.csv(m, file="cosine_dist_mat.csv") 
cosine_dist_mat

