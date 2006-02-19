Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWBSVaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWBSVaP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWBSVaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:30:14 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:3993 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1750894AbWBSVaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:30:13 -0500
Message-ID: <46653.128.237.252.29.1140384421.squirrel@128.237.252.29>
In-Reply-To: <20060219191552.GB4971@stusta.de>
References: <1174.128.237.252.29.1140376277.squirrel@128.237.252.29>
    <20060219191552.GB4971@stusta.de>
Date: Sun, 19 Feb 2006 16:27:01 -0500 (EST)
Subject: Re: kernel panic with unloadable module support... SMP
From: "George P Nychis" <gnychis@cmu.edu>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I downloaded the 2.6.16-r4 kernel and left it unmodified and I do not get the panic.

Can you suggest anything for me so that I can find what is causing the panic with the gentoo vanilla sources?

http://www.andrew.cmu.edu/user/gnychis/dsc00257.jpg

Thanks!
George


> On Sun, Feb 19, 2006 at 02:11:17PM -0500, George P Nychis wrote:
> 
>> Hi,
> 
> Hi George,
> 
>> Whenever I compiled unloadable module support into my 2.6.15-r1 kernel,
>> my kernel panic's when booting up when it tries to load a module for
>> the first time.
>> 
>> I had this problem back with the 2.6.14 kernel, but figured it may have
>> been solved since then so I tried it... and still fails.
>> 
>> Unloadable module support would be very helpful to me.
>> 
>> I am using an intel p4 3.0ghz with SMP support built into the kernel. 
>> ...
> 
> What is 2.6.15-r1 for a kernel? Is your problem present in an unmodified
> 2.6.16-rc4 kernel from ftp.kernel.org?
> 
> If yes, please send the exact error messages. You might capture the
> messages with a digital camera and send a link to the photograph.
> 
>> Thanks! George
> 
> cu Adrian
> 
> --
> 
> "Is there not promise of rain?" Ling Tan asked suddenly out of the
> darkness. There had been need of rain for many days. "Only a promise," Lao
> Er said. Pearl S. Buck - Dragon Seed
> 
> 
> 


-- 

