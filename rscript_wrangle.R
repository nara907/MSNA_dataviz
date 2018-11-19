G9<-data.frame(variable=c("Lost (not due to conflict)",
                          "Stolen", 
                          "Expired and unable to renew here",
                          "Do not have enough money to re-apply",
                          "Other*"),
               Overall=c(6,9,49,6,36),
               Donetsk=c(5,5,51,0,39),
               Luhansk=c(8,16,44,15,24)

)
G9
J5<-data.frame(variable=c("Lack of functional health facility",
                          "Medical facilities are too far",
                          "Security constraints",
                          "Lack of referral system",
                          "Unable to afford medicines",
                          "Expensive transportation cost",
                          "Need to pay to see a doctor and too expensive",
                          "Need to pass through an external checkpoint to GCA",
                          "Pharmacy or health care facility inaccessible to PwD",
                          "Lack of documentation",
                          "Irregular presence of doctor",
                          "Other",
                          "Refused to answer"),
               Overall=c(2,9,1,3,45,6,15,2, 6,0,12,33, 1),
               Donetsk=c(2,8,1,3,50,5,17,3,8,0,8,30,1),
               Luhansk=c(2,10,2,3,37,6,12,1,3,1,18,39,0)
              
)
J5
M6<-data.frame(variable=c("Food needs",
                          "Education needs",
                          "Hygiene needs",
                          "Needs related to livelihoods",
                          "Legal assistance needs",
                          "Shelter and utilities",
                          "Agriculture needs",
                          "Medical needs",
                          "Health/nutrition needs",
                          "Other",
                          "No needs in humanitarian assistance",
                          "Don't know"),
               Overall=c(44,2,23,21,4,12,2,15, 9,9, 31,2),
               Donetsk=c(43,0,20,22,4,11,0,13,6,12,32,0),
               Luhansk=c(44,6, 28,21,4,14,7,18,13,5,30,6)
             
)
M6
E16.2<-data.frame(variable=c(
  "Pension from LPR/DPR",
  "Social payments from LPR/DPR",
  "Pension from Ukraine",
  "Social benefits from Ukraine",
  "Other"),
  n=c(69,28,13,2,3)
)

#RankTABLES

E8<-data.frame("n"=c("1. Mines", "2. Industry", "3. Service", "4. Trade"),
               "%"= c("18","17","13","11"))
colnames(E8)<-c("variable","n")

E12
E11<-data.frame("n"=c("1. Lack of work opportunities", "2. Less Pay", "3. Employer Closed"),
                nn=c(44,19,16))
colnames(E11)<-c("variable","n")


E12<-data.frame("n"=c("1. Pensions from DPR/LPR", "2. Salary in private sector", "3. Salary of state sector"),
                nn=c(29,27,24))
colnames(E12)<-c("variable","n")


G4<-data.frame("n"=c("1. Physical", "2. Mental", "3. Cardiovascular"),
               nn=c(39,16,14))
colnames(G4)<-c("variable","n")

G4
M2.2<-data.frame("n"=c("1. Food", "2. Cash", "3. Medical needs"),
                 nn=c(77,10,6))
colnames(M2.2)<-c("variable","n")

M2.2
#if contains "text" then delete column

M8<-data.frame(variable=c("Government institutions of Ukraine",
                          "Institutions of DPR/LPR",
                          "Local Humanitarian agencies",
                          "International Humanitarian organization",
                          "Religious institutions",
                          "For free from other organizations and companies",
                          "Other",
                          "Don't know/Won't answer"),
               
               n=c(9,23,7,29,2,1,20,11))

B2<-data.frame(variable=c("To be closer to friends or family",
                          "Access to work/livelihood",
                          "Free or cheap accommodation",
                          "Security increasing in the current area of living",
                          "Other*"),
               Donetsk=c(30,9,40,4,29),
               Luhansk=c(51,5,36,9,33))


B3<-data.frame(variable=c("Security concerns in former residence",
                          "Lack of educational services in former residence",
                          "To improve career access",
                          "Unemployment in former residence",
                          "Lack of health facilities",
                          "Shelter destroyed / poor shelter conditions",
                          "Already settled in new community",
                          "Need to care for elder/disabled HH member",
                          "Other*",
                          "Don`t know",
                          "Refuse to answer"),
               Donetsk=c(42,3,2,17,0,10,16,2,10, 5,2),
               Luhansk=c(18,7,6,40,3,9,25,3,13,0,0)
)
B3
D9.1<-data.frame(variable=c("Up to 3 hours per day",
                            "More than 3 hours",
                            "None",
                            "No central water supply"),
                 Donetsk=c(4,22,70, 4),
                 Luhansk=c(5,45,40,10))

F8<-data.frame(variable=c("1-2 months", "3-4 months", "Over 4 months"),
                 Donetsk=c(40,31,28),
                 Luhansk=c(72,21,7))
C4.1<-data.frame(variable=c("Monthly rent"),
               Donetsk=c(46.15),
               Luhansk=c(198.79))
E14.1<-data.frame(variable=c("HH Income"),
                 Donetsk=c(142.24),
                 Luhansk=c(98.79))
Expend<-data.frame(variable=c("Food","Health care/medicine", "Education","Transport","Hygiene Items","Clothes", "HH Items","Debt Repayment"),
                  n=c(231,112,75,53,33,76,16,16))

A6<-data.frame(variable=c("18-35 years old", "36-50 years old", "51-60 years old", "60+ years old"),
               Donetsk=c(-15,-29,-22,-34),
               Luhansk=c(23,36,20,21))

Pop<-data.frame(variable=c("GCA", "NGCA"),
               Urban=c(78.4,93.5),
               Rural=c(21.6,6.5))

