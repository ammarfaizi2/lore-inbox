Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVEaM3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVEaM3U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 08:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVEaM3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 08:29:20 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:62392 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261316AbVEaM3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 08:29:11 -0400
Message-ID: <429C1240.4040505@comcast.net>
Date: Tue, 31 May 2005 07:29:04 +0000
From: Terry Vernon <tvernon24@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com> <20050530093420.GB15347@hout.vanvergehaald.nl> <429B0683.nail5764GYTVC@burner> <46BE0C64-1246-4259-914B-379071712F01@mac.com> <429C4483.nail5X0215WJQ@burner>
In-Reply-To: <429C4483.nail5X0215WJQ@burner>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#!/bin/bash
######################################################
##                              CampFire Song v0.1                     
               ##
##                                 by Terry Vernon                     
                  ##
##   This is dedicated to those who like to keeping pouring fuel    ##
##           on that stack of burning tires which is this thread...    
     ##
######################################################

#######decalre variable#######
drool='This stupid thread lives!'

####loop it forever and ever####
while [ "$drool" == 'This stupid thread lives!' ]; do
        echo "This is the thread that never ends!"
        echo "It goes on and on my friends!"
        echo "One day people starting reading it not knowing what it was!"
        echo "They kept on replying to it just because..."
        echo ""
    if [ "$drool" != 'This stupid thread lives!' ]; then
        echo "Finally people have stfu about redundant crap!"
    fi
#just for anticipation...
    sleep 1
done
    echo "It just faded off..."






Joerg Schilling wrote:

>Kyle Moffett <mrmacman_g4@mac.com> wrote:
>
>  
>
>>>BTW: an implementation that uses something like Solaris does with
>>>/etc/path_to_inst and puts USB serial numbers into the path_to_inst
>>>kernel instance database could come very close to the desired result
>>>and would give stable SCSI addresses too.
>>>      
>>>
>>But why fix what isn't broken?  I can tell all my other programs, from
>>dd to mount, that I want to use the udev-created /dev/green_burner, so
>>why do you indicate such usage is _deprecated_ in cdrecord?  For such
>>device nodes, a _filesystem_ is the preferred name=>number index, so
>>why add an extra strange file "just because Solaris does".
>>    
>>
>
>If you use /dev/ entries to directly address SCSI targets, then you 
>are relying on on assumptions that cannot be granted everywhere.
>
>Cdrecord is portable and this needs to implement a way that is portable 
>and does not rely on nonportable assumptions like yours.
>
>
>  
>
>>And why again do you need stable SCSI addresses for my _USB_ drive?
>>    
>>
>
>Well if the udev program was polite to users, it would also support
>to edit /etc/default/cdrecord...... 
>
>... if it _really_ does wat you like with /dev/ links, then it has all 
>the information that is needed to also maintain /etc/default/cdrecord
>
>
>
>Jörg
>
>  
>

