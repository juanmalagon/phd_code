
##################################################################
##################################################################
### Specification 1: two factors                           ###
##################################################################
##################################################################




####################################################
## Step 0 : the FDH model
####################################################
  library(glpk)
  library(Rglpk)
  library(boot)
  library(np)
  library(stats)
  library(MASS)


#  my.Path <- file.path(file.choose())
  setwd(dirname("//econprofiles/profiles1/ndaaf84/Documents/Carla Haelermans/conditional efficiency"))
  data_file <- read.csv2("//econprofiles/profiles1/ndaaf84/Documents/Carla Haelermans/conditional efficiency/databestand_jun_28_2011.csv",header=TRUE)
  attach(data_file)

  FTE_BEDRAG_1lln      <-  FTE_BEDRAG_1 / LEERLAANT_TOTAAL
  FTE_BEDRAG_2lln      <-  FTE_BEDRAG_2  / LEERLAANT_TOTAAL
  FTE_BEDRAG_34lln     <-  FTE_BEDRAG_34 / LEERLAANT_TOTAAL
  MAT_KOSTEN2lln       <-  MAT_KOSTEN2   / LEERLAANT_TOTAAL



x <- cbind(FTE_BEDRAG_1lln, FTE_BEDRAG_2lln, FTE_BEDRAG_34lln, MAT_KOSTEN2lln)
y <- cbind(CE, AGGR_RENDEMENT)

ord <-  cbind(INNOV1, INNOV2, INNOV3, INNOV4, INNOV5)        # remark: schooldummy is unordered
fact <- cbind(CATEGORIE)
Q <- cbind(APCG, PERC_STED)
# bw_cx <- cbind(bw1,bw2,bw3,bw4,bw5,bw6,bw7)


   n  <- length(x[,1])
   i <-1
   yk <- y[i,]
   xk <- x[i,]
   p <- length(x[1,])
   q_y <- length(y[1,])
   q_ord <- ncol(ord)
   q_fact <- ncol(fact)

f <- function(theta,x,y,i,mm)                    # define a function, depending on the efficiency score theta
{
nsum <- 0; dsum <- 0
    for (j in (1:length(x[,1])))
{
     n <- (as.numeric( all(x[j,] <= x[i,] )) & (y[j,1] >=  (y[i,1] * theta )) & (y[j,2] >=  (y[i,2] * theta )) )       # indicator function to test whehter it is lower or higher than a specific value
      d <- (as.numeric(all(x[j,] <=  x[i,]))) 
# input     n <- (as.numeric(( all(y[j,] >=  y[i,] )) & (x[j,1] <= (x[i,1] * theta )) & (x[j,2] <= (x[i,2] * theta )) & (x[j,3] <= (x[i,3] * theta )) & (x[j,4] <= (x[i,4] * theta ))))       # indicator function to test whehter it is lower or higher than a specific value
# input     d <- (as.numeric(all(y[j,] >=  y[i,])))  
      
      nsum <- n+nsum                                        # you sum all these integrals
      dsum <- d+dsum
    }
  if(dsum==0)
  {
    dsum <- 1
  }
  return(1-(1-(nsum/dsum))^mm)
# input    return((1-(nsum/dsum))^mm)
}


eff.uncond <- matrix(nrow=length(x[,1]),ncol=1)              # define a matrix where you put your results
for (i in (1:length(x[,1])))
{
print(i)
eff <- integrate(f,0,Inf,x=x,y=y,i=i,mm=30)       # integrate from O to infinity
 eff.uncond[i] <- eff$value
 }

 write.matrix(eff.uncond, file = "orderm.txt", sep = " ")





####################################################
## Step 1 : the FDH model
####################################################


# Download the appropriate library
  library(boot)
  library(np)
  library(stats)
  library(MASS)

# first set options in .csv file on system operator
## To import the data: use system operators in tools!


n <- length(y[,1])

 number_exogenous <- length(ord[1,]) + length(fact[1,]) + length(Q[1,])



## STEP 1: Select the appropriate multivariate mixed bandwidth
    ## We select the appropriate bandwidth for every observation

  bw_cx <- matrix(nrow=length(x[,1]),ncol=number_exogenous)
  i <- 1
   for (i in (1:length(x[,1])))
   {
     
   flag_i <-  (x <= x[i,] )
     flag <- matrix(nrow=length(x[,1]),ncol=1) 
    for (j in (1:length(x[,1])))
    {
    flag[j] <- all(flag_i[j,])
    }
    print(i)
    flag_x <- subset(x,subset=flag,drop=TRUE)
    flag_Q <- subset(Q,subset=flag,drop=TRUE)
    flag_ord <- subset(ord,subset=flag,drop=TRUE)
    flag_fact <- subset(fact,subset=flag,drop=TRUE)
    flag_y <- subset(y,subset=flag,drop=TRUE)

  if((length(flag_y))<=12)               # length is the number of elements
    {
      bw_cx[i,1:(number_exogenous)] <-  cbind(matrix(data=1,nrow=1,ncol=number_exogenous))
        } else
      {
           data_ord <- matrix(nrow=length(flag_ord[,q_ord]))
            for (z in (1:length(flag_ord[1,])))
            {
            data_or <- data.frame(ordered(flag_ord[,z]))
            data_ord <- data.frame(data_ord, data_or)
            }
          data_fact <- matrix(nrow=nrow(t(flag_fact)),ncol=q_fact)
      
         #   for (z in (1:q_fact)
         #   {
            data_or <- data.frame(ordered(flag_fact))
            data_fact <- data.frame(data_fact, data_or)
         #   }
            data_fr <- data.frame(data_ord[,2:(length(flag_ord[1,])+1)], data_fact[,2], flag_Q)

       
     #  bw <-  npcdensbw(ydat=flag_y,xdat=data_fr,cykertype="epanechnikov",cxkertype="epanechnikov",oxkertype="liracine",bwmethod="cv.ls")
      bw <-  npcdensbw(ydat=flag_y,xdat=data_fr,cykertype="epanechnikov",cxkertype="epanechnikov",oxkertype="liracine",fast = TRUE, itmax = 100, tol = .1, ftol = .1)
      bw_cx[i,] <- bw$xbw
      }
    }

    # correction for estimation the CDF instead of the PDF:
        bw_cx[ ,1:(length(ord[1,]))] <-     bw_cx[ ,1:(length(ord[1,]))] * n^((2/(5+ length(Q[1,])))-(2/(4+length(Q[1,]))))  
      # continuous
   bw_cx[ ,(length(ord[1,])+1):(length(ord[1,])+length(Q[1,]))] <-     bw_cx[ ,(length(ord[1,])+1):(length(ord[1,])+length(Q[1,]))] * n^((1/(5+ length(Q[1,])))-(1/(4+length(Q[1,])))) 
  
    # save the output of the first step
    write.matrix(bw_cx, file = "bandwidth1.txt", sep = " ")      # before opening the .txt file, first reset the options for system separators




## STEP 2: Estimate the conditional efficiency estimates by the integral
  data_ord <- matrix(nrow=length(ord[,1]))
            for (z in (1:length(ord[1,])))
            {
            data_or <- data.frame(ordered(ord[,z]))
            data_ord <- data.frame(data_ord, data_or)
            }
  data_fact <- matrix(nrow=nrow(t(fact)),ncol=q_fact)
            data_or <- data.frame(ordered(fact))
            data_fact <- data.frame(data_fact, data_or)
            dat <- data.frame(data_ord[,2:(length(ord[1,])+1)], data_fact[,2], Q)

       
          

f <- function(theta,x,y,i,mm)                    # define a function, depending on the efficiency score theta
{

  tdata <- dat[i,]
####### USE   bw_cx[i,]
  kerz <- npudens(bws=bw_cx[i,],cykertype="epanechnikov",cxkertype="epanechnikov",oxkertype="liracine",tdat=tdata,edat=dat)
  kerz <- kerz$dens
  nsum <- 0; dsum <- 0
    for (j in (1:length(x[,1])))
    {
     n <- (as.numeric( all(x[j,] <= x[i,] )) & (y[j,1] >=  (y[i,1] * theta )) & (y[j,2] >=  (y[i,2] * theta )) ) * kerz[j]       # indicator function to test whehter it is lower or higher than a specific value
     d <- (as.numeric(all(x[j,] <=  x[i,])))  * kerz[j]
# input     n <- (as.numeric( all(x[j,] <= x[i,] )) & (y[j,1] >=  (y[i,1] * theta )) & (y[j,2] >=  (y[i,2] * theta ))) * kerz[j]       # indicator function to test whehter it is lower or higher than a specific value
# input      d <- (as.numeric(all(x[j,] <=  x[i,])))  * kerz[j]
      nsum <- n+nsum                                        # you sum all these integrals
      dsum <- d+dsum
    }
  if(dsum==0)
  {
    dsum <- 1
  }
   return(1-(1-(nsum/dsum))^mm)
  # input  return((1-(nsum/dsum))^mm)
}


eff.int <- matrix(nrow=length(x[,1]),ncol=1)              # define a matrix where you put your results
for (i in (1:length(x[,1])))
{
    print(i)
    eff <-      integrate(f,0,Inf,x=x,y=y,i=i,mm=30,stop.on.error=FALSE)
  if(eff$value<=0.01)
  {
    eff.int[i] <- 1
  } else
  {
   eff.int[i] <- eff$value
  }
}
eff.int

    # save the output of the second step
    write.matrix(eff.int, file = "conditional_eff.txt", sep = " ")









###############
#### STEP 2 : Explaining efficiency
##############


 effratio <-  eff.int / eff.uncond

  data_ord <- matrix(nrow=length(ord[,1]))
            for (z in (1:length(ord[1,])))
            {
            data_or <- data.frame(ordered(ord[,z]))
            data_ord <- data.frame(data_ord, data_or)
            }
  data_fact <- matrix(nrow=nrow(t(fact)),ncol=q_fact)
            data_or <- data.frame(ordered(fact))
            data_fact <- data.frame(data_fact, data_or)
            dat <- data.frame(data_ord[,2:(length(ord[1,])+1)], data_fact[,2], Q)

       

bw2 <- npregbw(ydat=effratio[,1], xdat = dat, bwmethod = "cv.ls", regtype="ll", ckertype="epanechnikov",oxkertype="liracine")

model2 <- npreg(bws=bw2, gradients=TRUE)
plot21<-npplot(bws=bw2,xq=0.25, common.scale=FALSE)
plot22<-npplot(bws=bw2,xq=0.5, common.scale=FALSE)
plot23<-npplot(bws=bw2,xq=0.75, common.scale=FALSE)
signif <- npsigtest(bws=bw2, boot.num= 500)
betas2<-model2$grad
se2<-model2$gerr    
summary(betas2)
colMeans(betas2)
summary(se2)
signif
model2$R2






