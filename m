Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVCUWx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVCUWx0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVCUWvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:51:52 -0500
Received: from nijmegen.renzel.net ([195.243.213.130]:47779 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S261977AbVCUWra
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:47:30 -0500
X-Spam-Report: SA TESTS
 -1.7 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                             [score: 0.0000]
Message-ID: <423F4F1F.3010905@twisted-brains.org>
Date: Mon, 21 Mar 2005 23:47:59 +0100
From: Mws <mws@twisted-brains.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2/2] SquashFS
References: <20050314170653.1ed105eb.akpm@osdl.org> <423727BD.7080200@grupopie.com> <20050321101441.GA23456@elf.ucw.cz> <200503211908.46602.mws@twisted-brains.org> <20050321185418.GC1390@elf.ucw.cz> <423F496C.10004@twisted-brains.org> <20050321223146.GM1390@elf.ucw.cz>
In-Reply-To: <20050321223146.GM1390@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi,
>
-snip-

>>>>but if there is a contribution from the outside - it is not taken "as is" 
>>>>and maybe fixed up, which
>>>>should be nearly possible in the same time like analysing and commenting 
>>>>the code - it ends up
>>>>in having less supported hardware. 
>>>>
>>>>imho if a hardware company does indeed provide us with opensource 
>>>>drivers, we should take these
>>>>things as a gift, not as a "not coding guide a'like" intrusion which
>>>>has to be defeated.
>>>>        
>>>>
>>>Remember that horse in Troja? It was a gift, too.
>>>      
>>>
>
>  
>
>>of course there had been a horse in troja., but thinking like that 
>>nowadays is a bit incorrect - don't you agree?
>>
>>code is reviewed normally - thats what i told before and i stated as 
>>good feature - but there is no serious reason
>>to blame every code to have potential "trojan horses" inside and to 
>>reject it.
>>    
>>
>
>I should have added a smiley.
>
>I'm not seriously suggesting that it contains deliberate problem. But
>codestyle uglyness and arbitrary limits may come back and haunt us in
>future. Once code is in kernel, it is very hard to change on-disk
>format, for example.
>								Pavel
>  
>
yes, i agree at that point. but, there are many people using this 
already and if it will _not_ become merged to
mainline kernel, maybe these portions of code will get lost.

ps: pavel, don't take my opinions as a personal attack or something like 
this. it is just to bring out my thinking
of how things "could" be.

