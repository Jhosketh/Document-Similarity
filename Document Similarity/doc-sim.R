# Constant
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
