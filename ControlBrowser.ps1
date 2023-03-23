

$BrowserName = "firefox"
$Width=770#1920/5 3840/5 = 768 Determines the width of the browser window. There might be some limitations as to what the smallest size actually is. 
$WindowSpacing = 0 #Seems like 452 is the smallest a Firefox window can be
$Height=2160  
$YOffset = -1080 #This is realtive to where the next display starts/ends. Use "Mouse position tracker" if in doubt
$XOffset = 876 #Like the one above.  
$Global:Screen1Width = 3840 

$Global:URLs = @(("https://nrk.no" , "https://nrk.no/trondelag"),("https://vg.no", "https://dagbladet.no", "https://dn.no", "https://storyboard.news"), {"https://adressa.no"} , ("https://nidaros.no", "https://namdalsavisa.no", "https://t-a.no", "https://underdusken.no", "https://gemini.no"), ("https://bladet.no", "https://fosna-folket.no", "https://innherred.no", "https://retten.no" , "https://opp.no", "https://avisa-st.no"),{"https://some.url.com"},("https://some.other.url.com" , "https://tavla.entur.no/t/", "https://trends.google.com/"))

$Global:BrowserSizes = @(($Width,$Height),($Width,$Height),($Width,$Height),($Width,$Height),($Width,$Height),((1920/2), 1080), ((1920/2), 1080))
$Global:BrowserCtr = 0

$Global:NumberOfBrowsers = 5 #Set the desired number of browsers. 

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#DO NOT TOUCH the vars below- unless you know what you are doing..

$Global:URLCounter = 0  
$Global:NextXPosition = 0
$Global:NextYPosition = 0

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

#Load Set-Window.script into memory
. .\Set-Window.ps1
# FUNCTIONS 


function CreateTabs
{
    param
    (
        $BrowserCtrNumber
    )

    Write-Host "Create-Tabs: BrowserCTR " $BrowserCtrNumber
    $URLsLeft = $Global:URLs[$BrowserCtrNumber].Count


    for ($i = 0; $i -lt $Global:URLs[$BrowserCtrNumber].Count; $i++) 
    {
        Write-Host "There are " $Global:URLs[$BrowserCtrNumber].Count " URLs in this position"
        
        $browserargs = "-new-tab -url " + $Global:URLs[$BrowserCtrNumber][$i]
        

        if ($URLsLeft -gt 0 ) 
        {
            Write-host "----------------------------------------------------------"
            Write-Host "URL pointer is " $i 
            Write-Host "URLs left to fill:" $URLsLeft 
            Write-Host "Current URL: "$Global:URLs[$BrowserCtrNumber][$i]
            Write-Host "BrowserArgs: " $browserargs
            Write-host "----------------------------------------------------------"

            Start-Process $BrowserName -ArgumentList $browserargs
            $URLsLeft --
        } 
        else 
        {
            Write-Host "No more URLs to fill - bailing"
            break
        }
        #pause
    }
  
    $Global:URLCounter ++
}


function StartBrowser
{
    
    for ($i = 0; $i -le $Global:URLs.Count; $i++) #The number of URLs dictates the number of browser windows required. 
    {
        Write-Host ""
        Write-Host "#######################"
        Write-Host "StartBrowser: Starting browser nr." $i " of " $Global:URLs.Count 
        Write-host "Window Height is :" $Global:BrowserSizes[$i][0]
        Write-host "Window Width is :" $Global:BrowserSizes[$i][1]
        Write-Host "X:Position " $Global:NextXPosition
        Write-host "Y:Position " $Global:NextYPosition

        $browserargs = "-new-window "
        
        Start-Process $BrowserName -ArgumentList $browserargs
        #   Get the list of all current browser processes.[]    
       
        Start-Sleep(2) #Needed, as Firefox uses a few seconds to boot, and get ready. 

        CreateTabs $i
        
        Start-Sleep 3
    
        #Set-Window -ProcessName $BrowserName -X $NextXPosition -Y 0 -Width $Width -Height $Height
        
        #Start browsers with size values set in the global array BrowserSizes.Position 0 is Widtht, Position 1 is Height 
        Set-Window -ProcessName $BrowserName -X $NextXPosition -Y $Global:NextYPosition -Width $Global:BrowserSizes[$i][0] -Height $Global:BrowserSizes[$i][1]
        
        if($i -eq ($Global:URLs.Count - 1)) 
        {
            Write-Host "No more browsers to fill - bailing"
            break

        }


        if (($Global:NextXPosition + $Global:BrowserSizes[$i][0]) -le $Global:Screen1Width) 
        {
            $Global:NextXPosition = $NextXPosition + $Global:BrowserSizes[$i][0] + $WindowSpacing

        }
        else
        {
            Write-Host "Reached the end of Screen 1"
            $Global:NextYPosition = $YOffset
            $Global:NextXPosition = $XOffset
        }   
        
        

        $Global:NumberOfBrowsers --
        Write-Host "Next position in X orientation to fill is " $Global:NextXPosition
        Write-Host "Done with " $i
        Write-Host "##############################"
        
        
    }
}





#SCRIPT

. .\Set-Window.ps1
StartBrowser
