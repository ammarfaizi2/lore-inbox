Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVCUXZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVCUXZQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVCUWym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:54:42 -0500
Received: from nijmegen.renzel.net ([195.243.213.130]:676 "EHLO mx1.renzel.net")
	by vger.kernel.org with ESMTP id S262128AbVCUWxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:53:32 -0500
X-Spam-Report: SA TESTS
 -1.7 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                             [score: 0.0000]
Message-ID: <423F5091.2030906@twisted-brains.org>
Date: Mon, 21 Mar 2005 23:54:09 +0100
From: Mws <mws@twisted-brains.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Phillip Lougher <phillip@lougher.demon.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
References: <20050314170653.1ed105eb.akpm@osdl.org> <A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk> <20050314190140.5496221b.akpm@osdl.org> <423727BD.7080200@grupopie.com> <20050321101441.GA23456@elf.ucw.cz> <423EEEC2.9060102@lougher.demon.co.uk> <20050321190044.GD1390@elf.ucw.cz> <423F4B88.8020504@twisted-brains.org> <20050321224403.GP1390@elf.ucw.cz>
In-Reply-To: <20050321224403.GP1390@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>[I'm not sure if I should further feed the trolls.]
>  
>
>>>Yes, it *is* rather unfair. Sorry about that. But having 2 different
>>>limited compressed filesystems in kernel does not seem good to me.
>>>      
>>>
>
>  
>
>>what do you need e.g. reiserfs 4 for? or jfs? or xfs? does not ext2/3 
>>the journalling job also?
>>is there really a need for cifs and samba and ncpfs and nfs v3 and nfs 
>>v4? why?
>>    
>>
>
>Take a look at debate that preceded xfs merge. And btw reiserfs4 is
>*not* merged.
>
>And people merging xfs/reiserfs4/etc did address problems pointed out
>in their code.
>								Pavel
>  
>
i do not know if i act like a troll - i think a troll is something 
totally different.

yes of course i know xfs or e.g. the kernel version named debate. but - 
seriously - is it worth spending
so many time to discuss instead of just fixing the code meanwhile?
that is the main problem also in some other open source projects.
discussing instead of developing - not really efficient.

ps. FYI no, i am not a troll, and i am also taking part in some open 
source projects contributing code.

regards
marcel


