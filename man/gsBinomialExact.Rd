\name{gsBinomialExact}
\alias{gsBinomialExact}
\alias{print.gsBinomialExact}
\alias{plot.gsBinomialExact}
\alias{binomialSPRT}
\alias{plot.binomialSPRT}
%\alias{gsBinomialPP}
\alias{nBinomial1Sample}
\title{3.4: One-Sample Binomial Routines}
\description{

\code{gsBinomialExact} computes power/Type I error and expected sample size for a group sequential design
in a single-arm trial with a binary outcome.
This can also be used to compare event rates in two-arm studies.
The print function has been extended using \code{print.gsBinomialExact} to print \code{gsBinomialExact} objects; see examples.
Similarly, a plot function has been extended using \code{plot.gsBinomialExact} to plot \code{gsBinomialExact} objects; see examples.

\code{binomialSPRT} computes a truncated binomial sequential probability ratio test (SPRT) which is a specific instance of an exact binomial group sequential design for a single arm trial with a binary outcome. 

%\code{gsBinomialPP} computes a truncated binomial (group) sequential design based on predictive probability.

\code{nBinomial1Sample} uses exact binomial calculations to compute power and sample size for single arm binomial experiments. 
}

\usage{
gsBinomialExact(k=2, theta=c(.1, .2), n.I=c(50, 100), a=c(3, 7), b=c(20,30))
binomialSPRT(p0,p1,alpha,beta,minn,maxn)
nBinomial1Sample(p0 = 0.90, p1=0.95, 
                 alpha = 0.025, beta=NULL, 
                 n = 200:250, outtype=1, conservative=FALSE)
\method{plot}{gsBinomialExact}(x,plottype=1,\dots)
\method{plot}{binomialSPRT}(x,plottype=1,\dots)
}
\arguments{
	\item{k}{Number of analyses planned, including interim and final.}
	\item{theta}{Vector of possible underling binomial probabilities for a single binomial sample.}
	\item{n.I}{Sample size at analyses (increasing positive integers); vector of length k.}
	\item{a}{Number of "successes" required to cross lower bound cutoffs to reject \code{p1} in favor of \code{p0} at each analysis; vector of length k; -1 means no lower bound.}
	\item{b}{Number of "successes" required to cross upper bound cutoffs for rejecting \code{p0} in favor of \code{p1} at each analysis; vector of length k.}
  \item{p0}{Lower of the two response (event) rates hypothesized.}
  \item{p1}{Higher of the two response (event) rates hypothesized.}
  \item{alpha}{Nominal probability of rejecting response (event) rate \code{p0} when it is true.}
  \item{beta}{Nominal probability of rejecting response (event) rate \code{p1} when it is true.}
  \item{minn}{Minimum sample size at which sequential testing begins.}
  \item{maxn}{Maximum sample size.}
  \item{x}{Item of class \code{gsBinomialExact} or \code{binomialSPRT} for \code{print.gsBinomialExact}. Item of class \code{gsBinomialExact} for \code{plot.gsBinomialExact}. Item of class \code{binomialSPRT} for item of class \code{binomialSPRT}.}
  \item{plottype}{1 produces a plot with counts of response at bounds (for \code{binomialSPRT}, also produces linear SPRT bounds); 2 produces a plot with power to reject null and alternate response rates as well as the probability of not crossing a bound by the maximum sample size; 3 produces a plot with the response rate at the boundary as a function of sample size when the boundary is crossed; 6 produces a plot of the expected sample size by the underlying event rate (this assumes there is no enrollment beyond the sample size where the boundary is crossed).}
\item{n}{sample sizes to be considered for \code{nBinomial1Sample}. These should be ordered from smallest to largest and be > 0.}
\item{outtype}{Operative when \code{beta != NULL}. \code{1} means routine will return a single integer sample size while for \code{output=2} or \code{3} a data frame is returned (see Value).}
\item{conservative}{operative when \code{outtype=1} or \code{2} and \code{beta != NULL}. Default \code{FALSE} selects minimum sample size for which power is at least \code{1-beta}. When \code{conservative=TRUE}, the minimum sample sample size for which power is at least \code{1-beta} and there is no larger sample size in the input \code{n} where power is less than \code{1-beta}.}
\item{\dots}{arguments passed through to \code{ggplot}.}
}
\details{
\code{gsBinomialExact} is based on the book "Group Sequential Methods with Applications to Clinical Trials,"
Christopher Jennison and Bruce W. Turnbull, Chapter 12, Section 12.1.2 Exact Calculations for Binary Data.
This computation is often used as an approximation for the distribution of the number of events in one treatment group out of all events when the probability of an event is small and sample size is large.

An object of class \code{gsBinomialExact} is returned.
On output, the values of \code{theta} input to \code{gsBinomialExact} will be the parameter values for which the boundary crossing probabilities and expected sample sizes are computed.

Note that a[1] equal to -1 lower bound at n.I[1] means 0 successes continues at interim 1; a[2]==0 at interim 2 means 0 successes stops trial for futility at 2nd analysis. 
For final analysis, set a[k] equal to b[k]-1 to incorporate all possibilities into non-positive trial; see example.

The sequential probability ratio test (SPRT) is a sequential testing scheme allowing testing after each observation. This likelihood ratio is used to determine upper and lower cutoffs which are linear and parallel in the number of responses as a function of sample size. 
\code{binomialSPRT} produces a variation the the SPRT that tests only within a range of sample sizes.
While the linear SPRT bounds are continuous, actual bounds are the integer number of response at or beyond each linear bound for each sample size where testing is performed. Because of the truncation and discretization of the bounds, power and Type I error achieve will be lower than the nominal levels specified by \code{alpha} and \code{beta} which can be altered to produce desired values that are achieved by the planned sample size. See also example that shows computation of Type I error when futility bound is considered non-binding. 

Note that if the objective of a design is to demonstrate that a rate (e.g., failure rate) is lower than a certain level, two approaches can be taken. First, 1 minus the failure rate is the success rate and this can be used for planning. Second, the role of \code{beta} becomes to express Type I error and \code{alpha} is used to express Type II error.

Plots produced include boundary plots, expected sample size, response rate at the boundary and power.

\code{gsBinomial1Sample} uses exact binomial computations based on the base R functions \code{qbinom()} and \code{pbinom()}. The tabular output may be convenient for plotting. Note that input variables are largely not checked, so the user is largely responsible for results; it is a good idea to do a run with \code{outtype=3} to check that you have done things appropriately.
If \code{n} is not ordered (a bad idea) or not sequential (maybe OK), be aware of possible consequences.
}

\value{
\code{gsBinomialExact()} returns a list of class \code{gsBinomialExact} and \code{gsProbability} (see example); when displaying one of these objects, the default function to print is \code{print.gsProbability()}. 
The object returned from \code{gsBinomialExact()} contains the following elements: 
	\item{k}{As input.}
	\item{theta}{As input.}
	\item{n.I}{As input.}
	\item{lower}{A list containing two elements: \code{bound} is as input in \code{a} and \code{prob} is a matrix of boundary 
	crossing probabilities. Element \code{i,j} contains the boundary crossing probability at analysis \code{i} for the \code{j}-th element of \code{theta} input. All boundary crossing is assumed to be binding for this computation; that is, the trial must stop if a boundary is crossed.}
	\item{upper}{A list of the same form as \code{lower} containing the upper bound and upper boundary crossing probabilities.}
	\item{en}{A vector of the same length as \code{theta} containing expected sample sizes for the trial design
	corresponding to each value in the vector \code{theta}.}
  
\code{binomialSPRT} produces an object of class \code{binomialSPRT} that is an extension of the \code{gsBinomialExact} class. The values returned in addition to those returned by \code{gsBinomialExact} are:
  \item{intercept}{A vector of length 2 with the intercepts for the two SPRT bounds.}
  \item{slope}{A scalar with the common slope of the SPRT bounds.}
  \item{alpha}{As input. Note that this will exceed the actual Type I error achieved by the design returned.}
  \item{beta}{As input. Note that this will exceed the actual Type II error achieved by the design returned.}
  \item{p0}{As input.}
  \item{p1}{As input.}
  
\code{nBinomial1Sample} produces an integer if the input \code{outtype=1} and a data frame with the following values otherwise:
\item{p0}{Input null hypothesis event (or response) rate.}
\item{p1}{Input alternative hypothesis (or response) rate; must be \code{> p0}.}
\item{alpha}{Input Type I error.}
\item{beta}{Input Type II error except when input is \code{NULL} in which case realized Type II error is computed.}
\item{alphaR}{Type I error achieved for each output value of \code{n}; less than or equal to the input value \code{alpha}.}
\item{Power}{Power achived for each output value of \code{n}.}
\item{n}{sample size.}
\item{b}{cutoff given \code{n} to control Type I error; value is \code{NULL} if no such value exists.}


}
\seealso{\code{\link{gsProbability}}}
\note{The manual is not linked to this help file, but is available in library/gsdesign/doc/gsDesignManual.pdf
in the directory where R is installed.}
\author{Jon Hartzel, Yevgen Tymofyeyev and Keaven Anderson \email{keaven\_anderson@merck.}}
\references{
Jennison C and Turnbull BW (2000), \emph{Group Sequential Methods with Applications to Clinical Trials}.
Boca Raton: Chapman and Hall.

Code for nBinomial1Sample was based on code developed by marc_schwartz@me.com. 
} 

\examples{

zz <- gsBinomialExact(k=3,theta=seq(0,1,0.1), n.I=c(12,24,36),
        a=c(-1, 0, 11),  b=c( 5, 9, 12))

# let's see what class this is
class(zz)

# because of "gsProbability" class above, following is equivalent to 
# print.gsProbability(zz)
zz
# also plot (see also plots below for \code{binomialSPRT})
# add lines using geom_line()
plot(zz) + geom_line()

# now for SPRT examples
x <- binomialSPRT(p0=.05,p1=.25,alpha=.1,beta=.2)
# boundary plot
plot(x)
# power plot
plot(x,plottype=2)
# Response (event) rate at boundary
plot(x,plottype=3)
# Expect sample size at boundary crossing or end of trial
plot(x,plottype=6)

# sample size for single arm exact binomial

# plot of table of power by sample size
nb1 <- nBinomial1Sample(p0 = 0.05, p1=0.2,alpha = 0.025, beta=.2, n = 25:40, outtype=3)
nb1
library(scales)
ggplot(nb1,aes(x=n,y=Power))+geom_line()+geom_point()+scale_y_continuous(labels=percent)

# simple call with same parameters to get minimum sample size yielding desired power
nBinomial1Sample(p0 = 0.05, p1=0.2,alpha = 0.025, beta=.2, n = 25:40)

# change to 'conservative' if you want all larger sample
# sizes to also provide adequate power
nBinomial1Sample(p0 = 0.05, p1=0.2,alpha = 0.025, beta=.2, n = 25:40, conservative=TRUE)

# print out more information for the selected derived sample size
nBinomial1Sample(p0 = 0.05, p1=0.2,alpha = 0.025, beta=.2, n = 25:40, conservative=TRUE,outtype=2)

# what happens if input sample sizes not sufficient?
nBinomial1Sample(p0 = 0.05, p1=0.2,alpha = 0.025, beta=.2, n = 25:30)


}
\keyword{design}
