function Get-THR_Drivers {
    <#
    .SYNOPSIS 
        Gets a list of drivers for the given computer(s).

    .DESCRIPTION 
        Gets a list of drivers for the given computer(s).

    .PARAMETER Computer  
        Computer can be a single hostname, FQDN, or IP address.

    .EXAMPLE 
        Get-THR_Drivers 
        Get-THR_Drivers SomeHostName.domain.com
        Get-Content C:\hosts.csv | Get-THR_Drivers
        Get-THR_Drivers -Computer $env:computername
        Get-ADComputer -filter * | Select -ExpandProperty Name | Get-THR_Drivers

    .NOTES
        Updated: 2018-08-05

        Contributing Authors:
            Jeremy Arnold
            Anthony Phipps
            
        LEGAL: Copyright (C) 2018
        This program is free software: you can redistribute it and/or modify
        it under the terms of the GNU General Public License as published by
        the Free Software Foundation, either version 3 of the License, or
        (at your option) any later version.
    
        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details.

        You should have received a copy of the GNU General Public License
        along with this program.  If not, see <http://www.gnu.org/licenses/>.

    .LINK
       https://github.com/TonyPhipps/THRecon
    #>

    param(
    )

	begin{

        $DateScanned = Get-Date -Format u
        Write-Information -InformationAction Continue -MessageData ("Started {0} at {1}" -f $MyInvocation.MyCommand.Name, $DateScanned)

        $stopwatch = New-Object System.Diagnostics.Stopwatch
        $stopwatch.Start()

        # class Driver
        # {
        #     [string] $Computer
        #     [string] $DateScanned
            
        #     [string] $Provider
        #     [string] $Driver
        #     [String] $Version
        #     [datetime] $Date
        #     [String] $Class
        #     [string] $DriverSigned
        #     [string] $OrginalFileName
        # }

        # $Command = { 
            
        # }
    }

    process{

        Get-WindowsDriver -Online -ErrorAction SilentlyContinue

        foreach ($Result in $ResultsArray) {
            $Result | Add-Member -MemberType NoteProperty -Name "Host" -Value $env:COMPUTERNAME
            $Result | Add-Member -MemberType NoteProperty -Name "DateScanned" -Value $DateScanned
        }

        return $ResultsArray | Select-Object Host, DateScanned, ProviderName, Driver, Version, Date, ClassDescription, DriverSignature, OriginalFileName
            
        # $Computer = $Computer.Replace('"', '')  # get rid of quotes, if present
        
        # Write-Verbose ("{0}: Querying remote system" -f $Computer)

        # if ($Computer -eq $env:COMPUTERNAME){
            
        #     $ResultsArray = & $Command 
        # } 
        # else {

        #     $ResultsArray = Invoke-Command -ComputerName $Computer -ErrorAction SilentlyContinue -ScriptBlock $Command
        # }
       
        # if ($ResultsArray) { 
          
        #     $OutputArray = foreach ($driver in $ResultsArray) {
             
        #         $output = $null
        #         $output = [Driver]::new()
                
        #         $output.DateScanned = Get-Date -Format o
        #         $output.Computer = $Computer
        #         $output.Provider = $driver.ProviderName
        #         $output.Driver = $driver.Driver
        #         $output.Version = $driver.Version
        #         $output.date = $driver.Date
        #         $output.Class = $driver.ClassDescription
        #         $output.DriverSigned = $driver.DriverSignature
        #         $output.OrginalFileName = $driver.OriginalFileName

        #         $output
        #     }

        #     $total++
        #     Return $OutputArray
        
        # }
        # else {
                
        #     $output = $null
        #     $output = [Driver]::new()

        #     $output.Computer = $Computer
        #     $output.DateScanned = Get-Date -Format o
            
        #     $total++
        #     return $output
        # }
    }

    end{
        
        $elapsed = $stopwatch.Elapsed

        Write-Verbose ("Total time elapsed: {0}" -f $elapsed)
        Write-Verbose ("Ended at {0}" -f (Get-Date -Format u))
    }
}