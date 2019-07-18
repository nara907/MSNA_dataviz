library("openxlsx")
library("dplyr")
library("tidyr")
library(ggplot2)
library(ggthemes)
library("extrafont")
loadfonts(device = "win")

#download dataset
dataURL <- "http://www.reachresourcecentre.info/system/files/resource-documents/15._reach_yem_dataset_joint_market_monitoring_initiative_jmmi_may2019.xlsx"
temp = tempfile(fileext = ".xlsx")
download.file(dataURL, destfile=temp, mode='wb')
dataFILE<- read.xlsx(temp, sheet= 2)
dataFILE<- as.data.frame(dataFILE)


# RED, DARKGREY, TAN, PINK, LIGHTGREY, MEDGRAY, BLACK
cols <- c("#F05954",  "#57585A", "#D3CCB9",  "#F8AA9A", "#D1D2D4", 
          "#95A0A9", "#231F20")



#CIRCLE CHARTS
#Requirements: 5 options or less, all should add to 100%



#STACK BAR
#Requirements: 5 options or less, all should add to 100%

#BAR CHARTS
#Requirements: 7 options or less, MC or SO


###################################################################################################
## H E A T   T A B L E S  #########################################################################
#Requirements: ALL options

dataFILE1<-dataFILE[,c("governorate_name", "district_name", "type_area", "wash_prices")]

format_data_heatmap<- function(dataOI, disagg, questionV){
  dataOI %>% 
  group_by(disagg)%>%
  select(variable= questionV) %>%
  dplyr::count(variable)%>%
  mutate(value = round(100*(n / sum(n)),1))%>%
  select(-n)
}
two_way<-as.data.frame(table(subset(dataFILE1,select=c("type_area","wash_prices"))))
two_way2<-spread(two_way, wash_prices, Freq)
two_way2$n<- sum(two_way2$no)

format_data_heatmap(dataFILE1, "governorate_name", "wash_prices")

dataFILE2<-dataFILE1 %>% 
  group_by(governorate_name)%>%
  select(variable= wash_prices) %>%
  dplyr::count(variable)%>%
  mutate(value = round(100*(n / sum(n)),1))%>%
  select(-n)
  # spread(var,  perc)

ggplot(data = dataFILE2, mapping = aes(x = governorate_name,
                                                   y = reorder(variable,value),
                                                   fill = value)) + 
  geom_tile() +
  ylab(label="")+
  xlab(label = "")+
  scale_fill_gradient(name = "value",
                      low = "#FCDEDE",
                      high = "#EE5859")+
  geom_text(aes(x = governorate_name,
                y = variable,label=paste0(value, "%") ),
            family = "Arial Narrow",
            size=2.5)+
  scale_x_discrete(position = "top")+
  theme_tufte() +
  theme(text = element_text(family = "Arial Narrow", size=10),legend.position="none")
  #ggsave("G9_heatmap.png", width=8,height=0.8+0.6*nrow(OandV_t), dpi=300, units="cm")

heatmap1

#RANKING TABLE
#Requirements: ALL options, select top 3-5
heatmap_styling
