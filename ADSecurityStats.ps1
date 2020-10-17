function Get-ADSecurity{
        $hostname=(Get-ADDomainController).domain

        ## AD Statistics total ##

        $ADAccountDisabled=(Search-ADAccount -AccountDisabled).count
        #Search-ADAccount -AccountDisabled
        $ADCcountLockedOut=(Search-ADAccount -LockedOut).count
        $ADCountPasswordExpired=(Search-ADAccount -PasswordExpired).count
        $pwdNeverExp=(Get-ADUser -Filter * -Properties passwordneverexpires).count

        ##Password Reset stats per user##
        $dte=(Get-Date).AddMinutes(-30) #last 30 minutes
        $PWDUSERS=Get-ADUser -Filter 'PasswordLastSet -gt $dte' -Properties PasswordLastSet, PasswordNeverExpires | Sort-Object name | Select-Object Name, PasswordLastset
        #Seaching for accounts that changes in the last 30 minutes
        $counts=($PWDUSERS.name).count

        foreach ($PWDUSER in $PWDUSERS)
        {
        $pwdResetTime=$PWDUSER.PasswordLastSet
        $pwdResetTime=([DateTimeOffset] $pwdResetTime).ToUnixTimeMilliseconds()
        $PWDUSER=$PWDUSER.name

        #Format by removing spaces
        $group = $group -replace '\s','-'
        $PWDUSER=$PWDUSER -replace '\s','-'
        #$hostname=$hostname -replace '\.','-'
         Write-Host "ad_accounts,host=$hostname,ad_value=PasswordLastSet,instance=$PWDUSER status=1,pwdLastSetTime=$pwdResetTime"
         }
    
    Write-Host "ad_accounts,host=$hostname,ad_value=ADAccountDisabled total_=$ADAccountDisabled"
    Write-Host "ad_accounts,host=$hostname,ad_value=ADCountLockedOut total_=$ADCcountLockedOut"
    Write-Host "ad_accounts,host=$hostname,ad_value=ADCountPwdExpired total_=$ADCountPasswordExpired"
    Write-Host "ad_accounts,host=$hostname,ad_value=PasswordLastSet total_=$counts"
    Write-Host "ad_accounts,host=$hostname,ad_value=ADpwNeverExp total_=$pwdNeverExp"
}

Get-ADSecurity



