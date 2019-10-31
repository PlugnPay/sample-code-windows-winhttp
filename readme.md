  1.Purpose: The purpose of the COM is to communicate data (name value
    pairs) to the payment gateway and return the response (name value pairs) all
    over an encrypted link.  The COM can be used with multiple environments:
    Visual C++, Visual Basic, ASP, etc.  

   

  2.It is designed to behave like the Remote Method (modified integration
    specification: "A credit card authorization may be obtained by submitting
    the defined variables to the doTransaction method.  The doTransaction
    method will respond with a URL encoded text string suitable for parsing."). 

 

  3.Filename(s): The Name of the COM DLL is "pnpcom.dll".  

 

  4.Relevant Name(s): The 'ObjectName' is 'pnpcom'.  The 'ClassName' is
    'main'.  The 'MethodName' is 'doTransaction'.  In the pnpcom object is the
    class main that has a method doTransaction. 

 

  5.Registering the COM: 

     --------------------------------------------------------
     In the case of pnpcom.dll you need to do it manually by doing the following:
      
     Go to Start/Run and type: 
     Regsvr32 c:\winnt\system32\pnpcom.dll
      
     That will display a dialog to show if it was successful or failed.
      
     To un-register:
      
     Go to Start/Run and type:
     Regsvr32 /u c:\winnt\system32\pnpcom.dll
 
   6.   For ASP (Visual Basic Script)
     a.       Register the DLL as described in Step 5. above.
     b.       Create the object
      
     Set PNPObj = CreateObject("pnpcom.main?)
      
     c. Assign the name/value to a string
     STR = "&publisher-name=XXXinsertXXX&publisher-     
     email=test@plugnpay.com&ABC=123&card-name=pnptest&card-number=4111111111111111&card-amount=1.00&card-exp=01/01"
      
     d. Use the DoTransaction method to post the name/value to PlugNpay
      
      Results = PNPObj.DoTransaction(??, STR, ??,??)
      
     e. Display the results
     response.write "Results are " & Results
          
      f. Pass results into Hash Table for reference:
 
      Dim objResults
      Set objResults = Server.CreateObject("Scripting.Dictionary")
 
      myArray = split (Results,"&")
      for i = 0 to UBound(myArray)
        pos = inStr(1,myArray(i),"=")
        if (pos > 1) then
          myKey = Left(myArray(i),pos-1)
          myVal = Mid(myArray(i),pos+1)
          objResults.Item(myKey) = myVal
        End If
      Next
      
      g. Perform success test
     if(objResults.Item("FinalStatus") = "success") then 
        response.write "Place Transaction was successful Code Here"
      Else 
        response.write "Place Transaction failed Code Here"
      End If
 
 

  7.FAQ  

      
     QUESTION 1> Unknown Name/Value pairs in the example project --
     'ABC' with a value '123'.  These fields are NOT listed in the integration
     document.  What is it and is it mandatory?
      
     ANSWER 1> ABC=123 is bogus.  However it shows how you can add name
     value pairs of your own that will be returned to you?re your application (be it
     a page, or script, or other).
      
     QUESTION 2> There are missing mandatory name value pairs in the query
     example I can't find some of the mandatory fields (e.g. card-address1,
     card-city, card-state, card-zip, card-country).  Please clarify.
      
     ANSWER 2> card-name=pnptest will over ride the final status and force it
     successful.  The errors will still appear in the result reply.  Absence of some
     fields will result in defaults being applied.
      
     QUESTION 3> for some reason, when the COM is called from VisualBasic
     it only returns ABC=123& but when called from VC++ example project it
     returns everything. What is the cause of this?
      
     ANSWER 3> It appears that Visual Basic applications need the ?.tbl? file to
     be in the system32 directory.  
      
     QUESTION 4> I can run authorizations but when I try to run a void, return,
     any other type of transaction it fails complaining about: ?IP Not registered
     to username. Pleas contact tech support.? What is causing this?
      
     ANSWER 4>  Go to your admin area and login.  You should see a link for
     ?Security Administration? click the link and a new window should pop up. 
     There should be a form at the bottom of this page ?Remote Client
     Configuration? this is where you can register the IP addresses of your
     servers.
      
      

  8.Troubleshooting 

   
     If you find that the applications appears to hang.  Please update the wininet
     library on your server.  You can do this by upgrading to the latest version of
     IE 5.5.

     If you receive an error message "An exception of type 'unknown exception' was not handled"
     when the dll is called and you have IE 6.0 installed try uninstalling IE 6.0.
     This should cause windows to revert back to IE 5.X and should fix the problem.

