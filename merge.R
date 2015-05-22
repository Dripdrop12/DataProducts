setwd("C:/Users/PDAUSER/Desktop/Data Products")

library(lubridate)

# Committees #
com <- read.csv("Committee.csv")

# Member info #
mem <- read.csv("Member.csv", stringsAsFactors = FALSE)
mem$Primary.Function <- as.factor(mem$Primary.Function)
mem$Is.Member <- as.factor(mem$Is.Member)
mem$Email <- as.factor(mem$Email)
mem$Preferred.Country <- as.factor(mem$Preferred.Country)
mem$Assigned.Chapter <- as.factor(mem$Assigned.Chapter)
mem$Member.Type <- as.factor(mem$Member.Type)
mem$Join.Date <- as.Date(mem$Join.Date, format = "%m/%d/%Y")
mem$Membership.Duration <- as.numeric(ifelse(mem$Is.Member==TRUE,(today() - mem$Join.Date)/365,""),na.rm=TRUE)


# Orders #
ord <- read.csv("Order.csv")
ordMatrix <- model.matrix(~ Product.Category, data = ord)
ord$Product.Category <- NULL
ord <- cbind(ord,ordMatrix)
ordMatrix <- NULL
ord$Bill.To.ID <- as.factor(ord$Bill.To.ID)
ordagg <- t(sapply(by(ord[,2:ncol(ord)], ord$Bill.To.ID, colSums), identity))
ordagg <- as.data.frame(ordagg)
ordagg$Bill.To.ID <- as.factor(rownames(ordagg))
names(x = ordagg)[2] <- "Total.Orders"
ord <- ordagg
ordagg <- NULL

# Merge the tables #
memcom <- merge(x = com,
      y = mem,
      by.x = "Person.ID",
      by.y = "ID",
      all = TRUE
      )
dat <- merge(x = memcom,
             y = ord,
             by.x = "Person.ID",
             by.y = "Bill.To.ID",
             all = TRUE
             )
com <- NULL
mem <- NULL
ord <- NULL
memcom <- NULL
names(dat) <- gsub("Product.Category","",names(dat))
topcat <- sapply(dat[,13:72],sum,na.rm=TRUE)>1000
dat <- dat[,c(rep(TRUE, 12),names(dat[,13:72]) %in% names(topcat[topcat==TRUE]))]
dat$Person.ID <- NULL
EU <- c("Austria", "Belgium", "Bulgaria", "Croatia", "Czech Republic", "Cyprus", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Ireland", "Italy", "Kosovo", "Latvia", "Lithuania", "Luxembourg", "Malta", "Netherlands", "Poland", "Portugal", "Romania", "Slovakia", "Slovenia", "Spain", "Sweden", "Switzerland", "United Kingdom")
dat$EU <- dat$Preferred.Country %in% EU
dat$EU <- as.factor(dat$EU)
levels(dat$EU) <- c("Non-EU", "EU")
levels(dat$Email) <- c("Email Allowed","Email Exclude")
levels(dat$Is.Member) <- c("Non-Member", "Member")
names(dat) <- gsub(" ", "_",names(dat))
names(dat) <- gsub(":|/","",names(dat))
dat$Greater2011 <- as.factor(year(dat$Join.Date)>=2011)
levels(dat$Greater2011) <- c("LessThan2011","Greaterthan2011")
write.csv(dat, "dat.csv")


dt <- as.Date(c("2015-1-10","2015-1-15"))

mem2 <- mem[(mem$Join.Date >= dt[1] & mem$Join.Date <= dt[2]),]
mem2 <- mem2[!is.na(mem2$Join.Date),]
