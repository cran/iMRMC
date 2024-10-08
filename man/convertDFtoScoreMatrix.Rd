% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utilityFunctions.R
\name{convertDFtoScoreMatrix}
\alias{convertDFtoScoreMatrix}
\title{Convert an MRMC data frame to a score matrix}
\usage{
convertDFtoScoreMatrix(dfMRMC, modality = NULL, dropFlag = TRUE)
}
\arguments{
\item{dfMRMC}{An MRMC data frame}

\item{modality}{The score matrix depends on the modality.
If more than one modality exists in the data frame,
you must specify which modality to subset.}

\item{dropFlag}{[logical] The default setting (TRUE) removes readers and cases
that have no observations. Dropping them by default will speed up analyses.
Leaving the levels (dropFlag = FALSE) is useful if you need the entire score
or design matrix when comparing or doing analyses with two modalities.}
}
\value{
A matrix that is \emph{nCases} by \emph{nReaders} of the scores each reader reported for each case
}
\description{
Convert an MRMC data frame to a score matrix, dropping readers or cases with no observations
}
