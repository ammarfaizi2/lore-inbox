Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbVLDBTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVLDBTQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 20:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVLDBTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 20:19:16 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:20354 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S1751236AbVLDBTP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 20:19:15 -0500
Message-ID: <43923DD9.8020301@wolfmountaingroup.com>
Date: Sat, 03 Dec 2005 17:52:41 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de> <20051203162755.GA31405@merlin.emma.line.org> <1133630556.22170.26.camel@laptopd505.fenrus.org> <20051203230520.GJ25722@merlin.emma.line.org>
In-Reply-To: <20051203230520.GJ25722@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

>On Sat, 03 Dec 2005, Arjan van de Ven wrote:
>
>  
>
>>>Exactly that, and kernel interfaces going away just to annoy binary
>>>module providers also hurts third-party OSS modules, such as
>>>Fujitsu-Siemens's ServerView agents.
>>>      
>>>
>>in kernel API never was and never will be stable, that's entirely
>>irrelevant and independent of the proposal at hand.
>>    
>>
>
>It's still an annoying side effect - is there a list of kernel functions
>removed, with version removed, and with replacement? I know of none, but
>then again I don't hack the kernel very often.
>
>  
>
These folks have nothing new to innovate here. The memory manager and VM 
gets revamped every other release. Exports get broken, binary only 
module compatibility busted every rev of the kernel. I spend weeks on 
each kernel fixing the breakage. These people don't get it, don't care, 
and to be honest, you are wasting your time here trying to convince 
them. It's never stable because they don't want it to be. This is how 
they maintain control
of this code. I have apps written for Windows in 1990 and 1998 that 
still run on Windows XP today. Linux has no such concept of
backwards compatiblity. Every company who has embraced it outside of 
hardware based solutions is dying or has died. IBM is secretly
forking it as we speak and using it to get out of paying for Unix licenses.

As annoying as it is, accept it and live with it. These people have no 
sense of loyalty to you or your customers. They don't even care about 
each other.
Linux is not a "family" in any sense. I wanted very much to believe this 
and I was loyal to these folks for 10 years, invested millions of dollars
in development of my and others money in development to support it, 
crippled Novell and pushed them to embrace Linux and my reward was
smearing and expulsion from the community. They have no direction and 
the whole thing is stagnant now. All the development is incremental
bug fixes and anti-competitive mods to break each others distros.

You are standing on a battlefield. Quietly fork each release, make your 
mods, post patches somewhere for the poor civilians who are
"collateral damage" in the war with constantly busted software, and you 
might help some folks.

Jeff


