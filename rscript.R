library(readxl)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(reshape2)
library(ggthemes)
library(extrafont)
install.packages(("lemon"))
library(lemon)
library(ggrepel)
library(kableExtra)
library(DT)
font_import()
loadfonts(device = "win")

setwd("C:/Users/Nara/Documents/Projects/MSNA3/MSNA3")

dataT<-as.data.frame(read_excel("Dataset_fin_3.xlsx"))
dataT[ dataT == "NA" ] <- NA

dataT$A8
tryyy<- select(dataT, contains("B7."))
head(tryyy)


#WRANGLE

barcharts<-select(dataT, contains("A7."), contains("A8."),contains("C9."), contains("D1."),
                  contains("E2."), contains("E7."),
                  contains("D7."), contains("B6."),contains("B7."))

barcharts2<-select(dataT, contains("A6."), contains("D2."),contains("D8."), contains("M5."))

ranktables<-select(dataT, contains("E8."), contains("E12."),
                   contains("C2. Do you"), contains("C15. Are there"),
                   contains("D7."))
circlecharts<- select(dataT, contains("А5."), contains("B1."),
                      contains("C2. Do you"), contains("C15. Are there"),
                      contains("D7."),contains("D12."),contains("E10."),
                      contains("E22.9"),contains("F7."), contains("G3."),  contains("G7."),
                      contains("J4."),contains("M2.1"))
circlcharts2<-select(dataT, contains("E19.1"), contains("F4."),contains("F9"), contains("M10."))


OandV<-select(dataT, "Weight",contains("A1.1"), contains("H12.2"))
OandV<-OandV[,-3]
head(OandV)
colnames(OandV)<-c("weight", "oblast", "variable")
ungroup(OandV)




#HEATTABLES
heattables<- c("H12.2","H12.3","F9..")
B2
OandV<-select(dataT, "Weight",contains("A1.1 Current Oblast"), contains("F9"), -contains("Text"))
head(OandV)
colnames(OandV)<-c("weight", "Oblast", "variable")
head(OandV)
OandV<-na.omit(OandV)
OandV<-filter(OandV, variable!= "Untouched")
OandV<-filter(OandV, variable!= "I DON`T KNOW")
OandV

if (colnames(OandV)[2]=="Oblast") {
  OandV1<-OandV %>% group_by(variable, Oblast)
  Lsum<-sum((filter(OandV1,Oblast== "Luhansk Oblast"))$weight)
  Dsum<-sum((filter(OandV1,Oblast== "Donetsk Oblast"))$weight)

  OandV_g<-OandV1 %>% 
    filter(Oblast== "Luhansk Oblast") %>% 
    summarise(Luhansk=100*(sum(weight)/Lsum))  

  OandV_n<-OandV1 %>% 
    filter(Oblast== "Donetsk Oblast") %>% 
    summarise(Donetsk=100*(sum(weight)/Dsum))

  OandV_t<-OandV1 %>%
    ungroup() %>%
    group_by(variable)%>%
    summarise(Overall=100*(sum(weight)/(Dsum+Lsum)))
  
  OandV_t<-merge(OandV_t, OandV_n[,-2], all=TRUE)
  OandV_t<-merge(OandV_t, OandV_g[,-2], all=TRUE)
  return(OandV_t)
  
} else if (colnames(OandV)[2]!="oblast") {
  OandV1<-OandV %>% group_by(variable)
  
  OandV_g<-OandV1 %>% summarise(n=100*(sum(weight)/sum(OandV$weight)))
  return(OandV_g)
} else {
  return("im confused")
}


OandV_t
OandV_t[,1]<-c("Absence or lack of teachers due to conflict",
               "Administration does not manage the enrollment process",
               "Children under stress due to insecurity",
               "High transport costs to the institution",
               "Illness",
               "Other",
               "School closed",
               "School destroyed",
               "Security concerns"
)


H12.2<-OandV_t
H12.3<-OandV_t
OandV_t<-OandV_t[,-2]
OandV_t<-OandV_t[-1,]
OandV_t<-G9

data_long<- melt(OandV_t, id.vars = c("variable"))
colnames(data_long)<-c("variable", "oblast", "value")
data_long$value<-round(data_long$value, 0)
data_long$value<-as.numeric(data_long$value)
data_long
heatmap1 <- ggplot(data = data_long, mapping = aes(x = oblast,
                                                       y = reorder(variable,value),
                                                       fill = value)) + 
  geom_tile() +
  ylab(label="")+
  xlab(label = "")+  
  scale_fill_gradient(name = "value",
                                              low = "#FCDEDE",
                                              high = "#EE5859")+
  geom_text(aes(x = oblast,
                y = variable,label=paste0(value, "%") ),
            family = "Arial Narrow",
            size=2.5)+
  scale_x_discrete(position = "top")+
  theme_tufte() +
  theme(text = element_text(family = "Arial Narrow", size=10),legend.position="none")+
  ggsave("G9_heatmap.png", width=8,height=0.8+0.6*nrow(OandV_t), dpi=300, units="cm")

heatmap1


#CIRCLE CHART

circlecharts<- select(dataT, contains("А5."), contains("B1."),
                      contains("C2. Do you"), contains("C15. Are there"),
                      contains("D7."),contains("D12."),contains("E10."),
                      contains("E22.9"),contains("F7."), contains("G3."),  contains("G7."),
                      contains("J4."),contains("M2.1"))
OandV<-select(dataT, "Weight",contains("B7."), -contains("Text"))
head(OandV)
colnames(OandV)<-c("weight", "variable")
head(OandV)
OandV<-na.omit(OandV)

# RED, DARKGREY, TAN, PINK, LIGHTGREY, MEDGRAY, BLACK
cols <- c("#F05954",  "#57585A", "#D3CCB9",  "#F8AA9A", "#D1D2D4", 
          "#95A0A9", "#231F20")
OandV_g<-OandV_g[-2,]
OandV_g$variable<-c("1 person", "2 people", "3 people")
OandV_g[5,]<-c("Other*", 6.02)
OandV_g
p <- ggplot(OandV_g, aes(x=2, y=n/200, fill=variable))+
  geom_bar(stat="identity")+
  xlim(0.5, 2.5) +
  coord_polar(theta = "y")+
  labs(x=NULL, y=NULL)+
  labs(fill="") +
  scale_fill_manual(values = cols, labels=paste0(OandV_g$variable, " (", round(OandV_g$n), "%", ")"))+
  theme_bw()+
  theme(text = element_text(family = "Arial Narrow"),
        #plot.title = element_text(face="bold",family=c("sans"),size=15),
        #plot.margin = unit(c(6, 6, 6, 6), "cm"),
        legend.text=element_text(size=12),
        axis.ticks=element_blank(),
        axis.text=element_blank(),
        axis.title=element_blank(),
        panel.grid=element_blank(),
        legend.box.margin=margin(-10,-10,-10,-20),
        panel.border=element_blank())+
  ggsave("B7_donut.png", width=8,height=3, dpi=300, units="cm", scale = 2)

p


barcharts<-select(dataT, contains("A7."), contains("A8."),contains("C9."), contains("D1."),
                  contains("E2."), contains("E7."),
                  contains("D7."))
OandV<-select(dataT, "Weight",contains("C9."), -contains("Text"))
head(OandV)
colnames(OandV)<-c("weight", "variable")
head(OandV)
OandV<-na.omit(OandV)

E16.2
OandV_g<-OandV_g[-1,]
OandV_g<-OandV_g[-2,]
OandV_g<-OandV_g[-4,]
colnames(OandV_g)<-c("variable","n","D")
OandV_g<-Expend
OandV_g

red<-"#F05954"
grey<-"#57585A"
g <- ggplot(OandV_g, aes(variable, round(OandV_g$n)))+ 
  geom_bar(stat="identity", fill="#F05954") + #,width=0.09*height
  theme_classic(base_line_size = 0) +
  coord_flip()+
  geom_text(label=paste0(round(OandV_g$n),"%"), nudge_y = (max(OandV_g$n)-round(OandV_g$n)+25), family="Arial Narrow", size= 2.5)+
  theme(text = element_text(family = "Arial Narrow", size=10),
        axis.line=element_blank(),
        axis.text.y = element_text(margin = margin(r =-10)),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_blank())+
  ggsave("B3_barchart.png", width=10, height=0.4+0.4*nrow(OandV_g), dpi=300, units="cm")
g
#reformat
g <- ggplot(OandV_g, aes(reorder(variable, n), round(OandV_g$n)))+
  geom_bar(stat="identity", fill=red) + #,width=0.09*height
  theme_classic(base_line_size = 0) +
  coord_flip()+
  geom_text(label=paste0(round(OandV_g$n),"%"), nudge_y = -round(OandV_g$n)-4, family="Arial Narrow", size= 2.5)+
  theme(text = element_text(family = "Arial Narrow", size=10),
        axis.line=element_blank(),
        axis.text.y = element_text(margin = margin(r =17), hjust=0),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_blank())+
  ggsave("C9_barchart.png", width=9, height=0.4+0.35*nrow(OandV_g), dpi=300, units="cm")
g

OandV_g<-data_long
colnames(OandV_g)<-c("variable", "oblast","n")

#fascet

g <- ggplot(OandV_g, aes(reorder(variable,n), round(OandV_g$n)))+
  geom_bar(stat="identity", fill=red, width=0.5) + #,width=0.09*height
  theme_classic(base_line_size = 0) +
  coord_flip()+
  geom_text(label=paste0(round(OandV_g$n),"%"), nudge_y = 7, family="Arial Narrow", size= 2.4)+
  theme(text = element_text(family = "Arial Narrow", size=10),
        axis.line=element_blank(),
        axis.text.y = element_text(margin = margin(r =0/5), hjust=0),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        strip.text.y = element_blank(),
        strip.text.x = element_blank(),
        axis.text.x=element_blank())+
  facet_grid(~oblast)+
  ggsave("C9subset_barchart.png", width=8, height=0.4+0.4*nrow(OandV_g), dpi=300, units="cm")
g




#BarCHART 2


barcharts2<-select(dataT, contains("A6."), contains("D2."),contains("D8."), contains("M5."))
OandV<-select(dataT, "Weight",contains("A1.1 Current Oblast"), contains("J4."), -contains("Text"))
head(OandV)
colnames(OandV)<-c("weight", "Oblast", "variable")
head(OandV)
OandV<-na.omit(OandV)

OandV

OandV_t[,1]<-c("Elsewhere", "In own accomodation","In own yard")

OandV_t<-E14.1
OandV_t
OandV_t<-OandV_t[,-2]
OandV_t<-OandV_t[-1,]
OandV_t<-OandV_t[-2,]
OandV_t<-OandV_t[-4,]
data_long<- melt(OandV_t, id.vars = c("variable"))
colnames(data_long)<-c("variable", "Oblast", "value")
data_long$value<-round(data_long$value, 0)
max<-max(data_long$value, na.rm=TRUE)
max



g <- ggplot(data_long, aes(x=variable, y=value,fill=reorder(Oblast, value)))+ 
  geom_bar(stat="identity", position = "dodge") + 
  scale_fill_manual(values=c("#57585A","#F05954"))+
  theme_classic(base_line_size = 0) +
  coord_flip()+
  geom_text(data=data_long, aes(x = variable, y=max+15, label=paste("$",value)), position = position_dodge(width = 0.75),
            family="Arial Narrow", size= 2.5)+
  theme(text = element_text(family = "Arial Narrow", size=10),
        axis.line=element_blank(),
        axis.text.y = element_text(margin = margin(r =-9)),
        legend.key.size = unit(0.3,"cm"),
        legend.text=element_text(size=7),
        legend.title=element_text(size=7),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_blank())+
  ggsave("C9s_barchart2.png", width=10, height=0.4+0.8*nrow(OandV_t), dpi=300, units="cm")
g

#RANKING
okay<-kable(G4) %>%
  kable_styling(bootstrap_options = c("striped", "condensed"))
okay<-datatable(G4)
okay
knit_print.data.frame(okay)
kable_as_image(okay, filename = "table", file_format = "png",
               latex_header_includes = NULL, keep_pdf = FALSE, density = 300,
               keep_tex = FALSE)
