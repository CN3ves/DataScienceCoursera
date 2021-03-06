best <- function(state, outcome) {
    
    
    ## Read outcome data
    #open file
    data<-read.csv("outcome-of-care-measures.csv",colClasses="character")
    #select relevant information: names, state and conditions
    data<-data[,c(2,7,11,17,23)]
    #replace conditions names to match the input easily
    names(data)<-c("name","state","heart attack", "heart failure", "pneumonia")
    
    
    ## Check that state and outcome are valid
    #select information for input state
    stat<-data.frame()
    stat<-data[data$state==state,]
    if(nrow(stat)==0) {
        stop (paste(" invalid state"))
    }
    #select information of the condition on the selected state
    if(outcome=="heart failure" || 
           outcome=="heart attack" || 
           outcome=="pneumonia") {
        condition<-stat[,c("name",outcome)]
    }else {
        stop (paste(" invalid state"))
    }
    
    ## Return hospital name in that state with lowest 30-day death
    #check the minimum rate of all
    condition[,2]<-as.numeric(condition[,2])
    min<-min(condition[,2],na.rm=TRUE)
    #check hospitals with minimum value
    check<-condition[,2]==min
    hospital<-condition[check,1]
    hospital<-hospital[!is.na(hospital)]
    hospital[1]
    ## rate
}
