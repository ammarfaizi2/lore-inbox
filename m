Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288248AbSAQH2c>; Thu, 17 Jan 2002 02:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288255AbSAQH2X>; Thu, 17 Jan 2002 02:28:23 -0500
Received: from [202.135.142.194] ([202.135.142.194]:58116 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S288248AbSAQH2G>; Thu, 17 Jan 2002 02:28:06 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, large-discuss@lists.sourceforge.net,
        Heiko Carstens <Heiko.Carstens@de.ibm.com>,
        Jason McMullan <jmcmullan@linuxcare.com>,
        Anton Blanchard <antonb@au1.ibm.com>,
        Greg Kroah-Hartman <ghartman@us.ibm.com>
Subject: Re: [ANNOUNCE] HotPlug CPU patch against 2.5.0 
In-Reply-To: Your message of "Wed, 16 Jan 2002 18:21:42 -0800."
             <Pine.LNX.4.33L2.0201161815580.13155-100000@dragon.pdx.osdl.net> 
Date: Thu, 17 Jan 2002 18:28:14 +1100
Message-Id: <E16R6y7-00079N-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33L2.0201161815580.13155-100000@dragon.pdx.osdl.net> you
 write:
> Hi-
> 
> I've identified and fixed the problems on x86.
> There were problems in arch/i386/kernel/mtrr.c and bluesmoke.c.
> 
> In both cases, the problems are with __init functions
> and/or __initdata.
> 
> Patch is at end of email.  CPU online/offline support now works
> with mtrr.c and bluesmoke.c in my testing.

Hi,

	I've put it on my kernel page, and will upload to sf.net in a
little bit.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
