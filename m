Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281653AbRKPXrh>; Fri, 16 Nov 2001 18:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281655AbRKPXr1>; Fri, 16 Nov 2001 18:47:27 -0500
Received: from ns.suse.de ([213.95.15.193]:6155 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281653AbRKPXrQ>;
	Fri, 16 Nov 2001 18:47:16 -0500
Date: Sat, 17 Nov 2001 00:47:15 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AMD SMP capability sanity checking.
In-Reply-To: <3BF5A3FB.9000106@stesmi.com>
Message-ID: <Pine.LNX.4.30.0111170044170.32578-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Nov 2001, Stefan Smietanowski wrote:

> Ok, since you're misunderstanding me, where do I find out which is
> which, ie CPUID 660 is an ... and CPUID 670 is an ...

Ah, gotcha. Not sure off hand of any resource.
My x86info program has them documented in source form..
ftp://ftp.suse.com/pub/people/davej/x86info/

I'll extrapolate those into a human readable table, and put
it on my webpage sometime..  I've been meaning to put up
x86info dumps from various cpu's on there actually.
(I'll take this opportunity to ask anyone with a few spare
minutes to send -a output to me (NOT to linux-kernel btw))

> Point me to some good place to find out and I'm happy.

If you want to look at that source, its in AMD/identify.c
The last released version isn't aware of MP/XP's, but has the
earlier models covered.

regards,

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

