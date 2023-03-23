# BrowserSizePositionController
Controls the size, URLs and display position for Firefox browser windows. Usefull for info-TVs etc. 

Written by KLS March 2023


Thanks to proxB for the Set-Window script : https://github.com/proxb/PowerShell_Scripts/blob/master/Set-Window.ps1

TODO:

- Nothing :P 
- well...one could remove all the Write-Host debug-stuff. 

SYNOPSIS

- Controls start up of browsers, and controls window size and position. 
- Adds tabs from the Global:URLs array. The amount of tabs pr. browser is given by the count of members in the 2D Array $Global:URLs
- Sets Browser Window size according to the sizes set in the 2D array $Global: BrowserSizes 

REQUIREMENTS

- Set-Window script : https://github.com/proxb/PowerShell_Scripts/blob/master/Set-Window.ps1
- Firefox browser. 
- Plugins / extentions:
-   "I dont care about coockies" -> remmoves the "do you want to enable us to track your every move?" by answearing yes.
-   "Tab Rotator" -> Rotates between tabs in the current browser window. The setting "rotate the tabs in all windows" must be set
-   uBlcok Origin - > removes ads. Alternatively: AdBlock.  
- Mouse Position Tracker: https://github.com/Bluegrams/MPos
-   Used for figuring out the X Y coordinates, if in doubt.. 

USAGE

1: Create the URL list in $Global:URLs: If a browser is to have two or more URLs at any given time, enter: (url1, url2). I.e: ("https:\\some.url.com", "https:\\some.url.no"). 
   Note: If there is no more than 1 URL to be shown: change () to {} - otherwise the script will fail! 
   
2: Enter the desired width and height of each browser window in $Global:BrowserSizes. These can be set to an individual position  

3: Deside the number of browsers (browser windows allowed)

4: Figure out the X and Y offset values. In the main usecase for this script, the computer has 2 physical monitors, one 4K and one 1080p, due to graphics card limitations. Therefore the positioning of browsers on the
    second screen is a bit of a hit and miss, unless you know where to put the next window relative to the last. Use Mouse Position Tracker to figure out where the upper left corner of the screen is. 

LIMITATIONS

- Probably some.. there are some hard coded arguments that might not work on other browsers than Firefox atm. 
