# In this test we take an existing MRMC data set (from the getMRMCdataset 
# function) and test the conversions between matrixMode (case rows) and 
# listMode (observation rows).




# Get reading study results data frame
scores <- getMRMCdataset("prostateRawData")
scores$readerID <- factor(scores$readerID)
scores$caseID <- factor(scores$caseID)
scores$modalityID <- factor(scores$modalityID)

# Filter scores data to single modality
scores <- scores[scores$modalityID == "Hot", ]

# Get truth data frame
truth <- getMRMCdataset("prostateTruth")


# Merge truth and reader scores
prostateData <- rbind(truth, scores)

# Build a matrix of scores cases (rows) by readers (cols)
# scores.matrix <- matrix(nrow = nlevels(scores$caseID), ncol = nlevels(scores$readerID))
# rownames(scores.matrix) <- levels(scores$caseID)
# colnames(scores.matrix) <- levels(scores$readerID)

scores.split <- split(scores, scores$readerID)
# x <- scores.split[[1]]
# scores.matrix[, 1] <- x$score

for (i in 1:length(scores.split)) {
  
  y <- scores.split[[i]]
  temp <- merge(x, y, by = "caseID", all = TRUE)
  scores.matrix[, i] <- temp[, "score.y"]
}
# Get character array of readers
# readers <- unique(scores$Reader)
# # Convert MRMC data frame to `matrixMode` data frame 
# matrixDF <- tidyr::pivot_wider(scores, names_from = Reader, values_from = Confidence.score)
# OR
# matrixDF <- as.data.frame.matrix(xtabs(Confidence.score ~ Case.number + Reader, scores))
# matrixDF$Case.number <- row.names(matrixDF)
# matrixDF <- as.data.frame(matrixDF)
# # Convert `matrixDF` to MRMC data frame
# mrmcDF <- convertDF(inDF = matrixDF, inDFtype = "matrixMode", outDFtype = "listMode", 

matrixDF <- reshape(merge(prostateData, 
                          expand.grid(caseID = unique(prostateData$caseID), 
                                      readers = unique(prostateData$readerID)), 
                    all = TRUE), 
                    direction = "wide", 
                    idvar = "caseID", 
                    timevar = "readers")
