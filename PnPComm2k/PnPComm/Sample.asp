<%@ LANGUAGE="VBScript" %>

<%

 Set PNPObj = CreateObject("pnpcom.main")

 STR = "mode=debug&publisher-name=pnpdemo&publisher-email=test@plugnpay.com&card-name=pnptest&card-number=4111111111111111&card-amount=1.00&card-exp=01/01"
 Results = PNPObj.doTransaction("",STR,"","")

 Dim objResults
 Set objResults = Server.CreateObject("Scripting.Dictionary")

 myArray = split (Results,"&")
 for i = 0 to UBound(myArray)
   myArray(i) = replace(myArray(i),"+"," ")
   myArray(i) = replace(myArray(i),"%20"," ")
   myArray(i) = replace(myArray(i),"%21","!")
   myArray(i) = replace(myArray(i),"%23","#")
   myArray(i) = replace(myArray(i),"%24","$")
   myArray(i) = replace(myArray(i),"%25","%")
   myArray(i) = replace(myArray(i),"%26","&")
   myArray(i) = replace(myArray(i),"%27","'")
   myArray(i) = replace(myArray(i),"%28","(")
   myArray(i) = replace(myArray(i),"%29",")")
   myArray(i) = replace(myArray(i),"%2c",",")
   myArray(i) = replace(myArray(i),"%2d","-")
   myArray(i) = replace(myArray(i),"%2e",".")
   myArray(i) = replace(myArray(i),"%40","@")
   pos = inStr(1,myArray(i),"=")
   if (pos > 1) then
     myKey = Left(myArray(i),pos-1)
     myVal = Mid(myArray(i),pos+1)
     response.write myKey + " = " + myVal + "<br>"
     objResults.Item(myKey) = myVal
   End If
 Next
      
 if(objResults.Item("FinalStatus") = "success") then 
   response.write "Place Transaction was successful Code Here"
 Else 
   response.write "Place Transaction failed Code Here"
 End If

%>
