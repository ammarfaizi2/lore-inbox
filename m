Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWCSKrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWCSKrv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 05:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWCSKrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 05:47:51 -0500
Received: from [85.233.228.164] ([85.233.228.164]:4251 "EHLO botch.workgroup")
	by vger.kernel.org with ESMTP id S1751483AbWCSKrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 05:47:51 -0500
Message-ID: <441D36DA.2000701@overtag.dk>
Date: Sun, 19 Mar 2006 11:47:54 +0100
From: Benjamin Bach <benjamin@overtag.dk>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Idea: Automatic binary driver compiling system
References: <441AF93C.6040407@overtag.dk>	 <1142620509.25258.53.camel@mindpipe>  <441C213A.3000404@overtag.dk>	 <1142694655.2889.22.camel@laptopd505.fenrus.org>	 <441C2CF6.1050607@overtag.dk> <1142698292.2889.26.camel@laptopd505.fenrus.org>
In-Reply-To: <1142698292.2889.26.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wow, kudos to your work with the consequences of binary drivers. I 
certainly do not wish to add any redundant remarks of trolling sentences 
to this discussion. I've read +50 posts about binary drivers on this 
mailing list and in conclusion to that, I'd like to only add the following:

My idea was not to compromise the structure of the kernel. Nothing 
should be changed here. I also see a very notable resistance to binary 
drivers from distributions. Looking at the way ATI and NVidia drivers 
are treated by Fedora, SUSE and Ubuntu, I actually think they too have 
an agenda on this matter, and somehow it resembles their agenda on 
av-codecs. It's a sneaky-sneaky thing - if the user doesn't know a 
binary driver exists, we won't tell him. FC5 recently released made this 
huge "oops... we banned non-GPL modules in the kernel".

Anyways, I'm very happy with the combination of intelligence and 
idealism on this list, and suddenly I feel more attracted to writing a 
driver instead. For my Rio Karma mp3 player. It's a USB thing.. should 
be do-able in 3 months even though I've never written a driver.


Cheers everybody, and thanks for sharing! =)

/ Benjamin


Arjan van de Ven wrote:
> On Sat, 2006-03-18 at 16:53 +0100, Benjamin Bach wrote:
>   
>> Arjan van de Ven wrote:
>>     
>>> there are over a thousand open source drivers, and at most a handful
>>> binary ones. Please go do your math.
>>>   
>>>       
>> You're doing the wrong comparison. How many drivers are missing
>>     
>
> not too many. This is largely because hardware interfaces are getting
> increasingly standardized (it's cheaper for the hw vendors to not have
> to create a new driver for Windows XP)
>
>   
>>  or
>> lacking in ability?
>>     
>
> some. But the vast majority is "good enough" by any standard.
>
>   
>>  And if you add to your handful of binary drivers
>> those thousands that exist for xp...
>>     
>
> then it's clear that linux is better off ;)
> (and yes while XP has more drivers, in linux a driver would generally
> drive the hardware that in the windows world uses 10 to 20  drivers)
>
>   
>> well, numbers do change. Also, most open source drivers aren't made by
>> the vendors themselves.
>>     
>
> and? For standard interfaces... no big deal.
> And for non-standard interfaces.. it's increasingly done with the vendor
> help
>
>   
>> We're doing subjective math here. It doesn't change the fact that Linux
>> would be better off with improved hardware support, right?
>>     
>
> yes. But "more binary drivers" is absolutely not "better off"; but
> that's going towards the usual bimonthly troll topic so lets not go
> there and stop here.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>   

