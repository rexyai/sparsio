% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sparsio.R
\name{svmlight}
\alias{svmlight}
\alias{read_svmlight}
\alias{write_svmlight}
\title{Fast svmlight reader and writer}
\usage{
read_svmlight(file, type = c("CsparseMatrix", "RsparseMatrix",
  "TsparseMatrix"), zero_based = TRUE, ncol = NULL)

write_svmlight(x, y = rep(0, nrow(x)), file, zero_based = TRUE)
}
\arguments{
\item{file}{string, path to svmlight file}

\item{type}{target class for sparse matrix. \code{CsparseMatrix} is default value because it 
is main in R's \code{Matrix} package. However internally matrix first read into \code{RsparseMatrix} 
and then coerced with \code{as()} to target type.
This is because \code{smvlight} format is essentially equal to \code{CSR} sparse matrix format.}

\item{zero_based}{\code{logical}, whether column indices in file are 0-based (\code{TRUE}) or 1-based (\code{FALSE}).}

\item{ncol}{number of columns in target matrix. \code{NULL} means that number of columns will be determined 
from file (as a maximum index). However it is possible that user expects matrix with a predefined number of columns, 
so function can override inherited from data value.}

\item{x}{input sparse matrix. Should inherit from \code{Matrix::sparseMatrix}.}

\item{y}{target values. Labels must be an integer or numeric of the same length as number of rows in \code{x}.}
}
\description{
Reads and writes svmlight files. 
Notice that current implementation \bold{can't handle comments in svmlight files} during reading.
}
\examples{
library(Matrix)
library(sparsio)
i = 1:8
j = 1:8
v = rep(2, 8)
x = sparseMatrix(i, j, x = v)
y = sample(c(0, 1), nrow(x), replace = TRUE)
f = tempfile(fileext = ".svmlight")
write_svmlight(x, y, f)
x2 = read_svmlight(f, type = "CsparseMatrix")
identical(x2$x, x)
identical(x2$y, y)
}
