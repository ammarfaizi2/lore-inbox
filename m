Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277653AbRKICdd>; Thu, 8 Nov 2001 21:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279170AbRKICdY>; Thu, 8 Nov 2001 21:33:24 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:30445 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S277653AbRKICdL>; Thu, 8 Nov 2001 21:33:11 -0500
Date: Thu, 8 Nov 2001 18:01:21 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: David Grant <davidgrant79@hotmail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon cooling
In-Reply-To: <OE52hS3cHCyvzG5TDAi000115a8@hotmail.com>
Message-ID: <Pine.LNX.4.33.0111081752490.2404-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_APM_CPU_IDLE

in the apm setup...

clock throttling is a subject of some debate on the linux kernel list... ;) 
but the apm idle call will at least idle the cpu once the idle loop has 
been running for a while.

joelja

On Thu, 8 Nov 2001, David Grant wrote:

> There is a program for Windows called CPUIdle, which cools the Athlon
> tremendoulsy.  I can get my temp. from 52C down to 36C.  It makes the CPU
> truly go idle.  Is there anything like this for Linux, and I'm wondering if
> anyone knows the instructions (and/or signals) which could be used to put
> the Athlon into this state.  I guess it's more of a question for some APM
> guys, but I thought some people here might know the interface to the Athlon,
> and might thus know how this software cooling works.  Actually the low-level
> apm stuff is part of the kernel right?  so maybe this is on-topic.
> 
> http://www.cpuidle.de/
> 
> Cheers,
> David Grant
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli				       joelja@darkwing.uoregon.edu    
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.



