Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263521AbRFKIqC>; Mon, 11 Jun 2001 04:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263524AbRFKIpw>; Mon, 11 Jun 2001 04:45:52 -0400
Received: from tangens.hometree.net ([212.34.181.34]:48294 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S263521AbRFKIpp>; Mon, 11 Jun 2001 04:45:45 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
Date: Mon, 11 Jun 2001 08:45:43 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9g20fn$on4$1@forge.intermeta.de>
In-Reply-To: <9fq2ce$gkb$1@forge.intermeta.de> <200106082254.f58MsWE487361@saturn.cs.uml.edu>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 992249143 18769 212.34.181.4 (11 Jun 2001 08:45:43 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 11 Jun 2001 08:45:43 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

>Yep.

>Consider a chunk of x86 instructions using a home-grown OS
>abstraction layer, and drivers that implement that layer for
>both Linux and any non-GPL operating system. The binary blob
>is obviously not derived from Linux, and may in fact run
>without modification in a BSD or Solaris/x86 kernel.

I had an interesting discussion with my brother-in-law at this
weekend: What is source code?

In my (very much younger days), I used to hack in 8085 and Z80
assembler and even hex codes directly onto the disk / files using all
those scary tools like DDT and M80/L80 under CP/M (those were the days
when Microsoft tools were really bleeding edge. ;-) )

What if there is really a warbled indivdual that can write a driver in
object code? Or at least in x86 assembler and then performs the magic
necessary to link it into the kernel?

Is this a "binary only" driver or just a driver on par with the NVidia
that is just "GPL'ed but unreadable"?

	Regards
		Henning


-- 
Henning Schmiedehausen     "They took the credit for your second symphony. 
hps@intermeta.de            Rewritten by machine and "New Technology".         
henning@forge.franken.de    and now I understand the problems you can see."
                                                        -- The Buggles, 1979
