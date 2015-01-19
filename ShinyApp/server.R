library(shiny)
data(women)

# Prediction models
model<-lm(weight~height,data=women) # in/lbs model
#Convert units
women[,1]<-women[,1]*0.0254
women[,2]<-women[,2]*0.45359237 
model2<-lm(weight~height,data=women) # m/Kg model

#Server computations
shinyServer(function(input, output) {

# Height computations
    height<-reactive({
        temp<-gsub(",",".",input$iheight)
        temp<-as.numeric(temp)
        
        if (is.na(temp) && length(input$units)==0) { # predict with in/lbs
            value<-round((weight()-model$coef[1])/model$coef[2],2)
            value
        }else if (is.na(temp) && length(input$units)==1) { # predict with m/Kg
            value<-round((weight()-model2$coef[1])/model2$coef[2],2)
            value
        }else { # pass input value
            temp
        }
    })
    output$oheight<-renderText({height()})
    output$oheight2<-renderText({
        if (length(input$units)==0) {"inches"}
        else {"meters"}
    })

# Weight computations
    weight<-reactive({
        temp<-gsub(",",".",input$iweight)
        temp<-as.numeric(temp)
        
        if (is.na(temp) && length(input$units)==0) { # predict with in/lbs
            value<-round(height()*model$coef[2]+model$coef[1],2)
            value
        }else if (is.na(temp) && length(input$units)==1) { # predict with m/Kg
            value<-round(height()*model2$coef[2]+model2$coef[1],2)
            value
        }else { # pass input value
            temp
        }
    })
    output$oweight<-renderText({weight()})
    output$oweight2<-renderText({
        if (length(input$units)==0) {"pounds"}
        else {"Kilograms"}
    })

# BMI computations
    BMI<-reactive({
        if (length(input$units)==0) { # BMI with in/lbs
            BMI<-(weight()/height()^2)*730
            BMI
        }else { # predict with m/Kg
            BMI<-(weight()/height()^2)
            BMI
        }
    })
    output$obmi<-renderText({BMI()})
    output$obmi2<-renderText({
        if(BMI()<18.5) {"underweight"}
        else if(BMI()<25) {"normal"}
        else if(BMI()<30) {"overweight"}
        else {"obese"}
    })
})
