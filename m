Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265418AbUFXUJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265418AbUFXUJP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 16:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbUFXUJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 16:09:15 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:62732 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265418AbUFXUJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 16:09:11 -0400
Message-ID: <40DB396D.4090000@techsource.com>
Date: Thu, 24 Jun 2004 16:28:29 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: "Fao, Sean" <Sean.Fao@dynextechnologies.com>
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Amit Gud <gud@eth.net>
Subject: Re: Elastic Quota File System (EQFS)
References: <40d9ac40.674.0@eth.net> <200406231853.35201.mrwatts@fast24.co.uk> <1088016048.15211.10.camel@sage.kitchen> <001901c459cd_bc436e40_868209ca@home> <20040624115019.GA3614@suse.de> <20040624141742.GD698@openzaurus.ucw.cz> <40DB3263.40600@dynextechnologies.com>
In-Reply-To: <40DB3263.40600@dynextechnologies.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fao, Sean wrote:
> Pavel Machek wrote:
> 
>>>> What action should be taken can be specified by the user while 
>>>> making the
>>>> files elastic. He can either opt to delete the file, compress it or 
>>>> move it
>>>> to some place (backup) where he know he has write access. The 
>>>> corresponding
>>>>     
>>>
>>> - having files disappear at the discretion of the filesystem seems to be
>>>  bad behaviour: either I need this file, then I do not want it to just
>>>  disappear, or I do not need it, and then I can delete it myself.
>>>   
>>
>>
>>
>> Actually, think .o or mozilla cache files... You don't need them, but 
>> if you have them,
>> things are faster.
>>  
>>
> I fail to understand the point you're trying to make.  Are you 
> suggesting that a feature doesn't necessarily have to be implemented, 
> just because it's there?  If so, the proposed idea on the "elastic" file 
> system differs greatly.  Cached content, for instance, speeds up the 
> browsing experience *without* hindering the ability of the application 
> to function normally.  Caching is a true enhancement --in most 
> circumstances.  I can personally see no way to implement EQFS without 
> greatly exasperating end users with its shortcomings.
> 
> Sean
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

