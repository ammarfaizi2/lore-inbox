Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbVDAKLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVDAKLq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 05:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVDAKLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 05:11:46 -0500
Received: from tag.witbe.net ([81.88.96.48]:5319 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S262683AbVDAKL3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 05:11:29 -0500
Message-Id: <200504011011.j31ABMb06831@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Dave Jones'" <davej@kernelslacker.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Free Linux-like kernel sources for x86-64
Date: Fri, 1 Apr 2005 12:11:23 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <20050401080022.GA10834@kernelslacker.org>
Thread-Index: AcU2kYRvA7ANfUxsSNO/+dsUhdkXcAAEZMAg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reminds me of something, but can't find what... Gee... Is it really that old
? 

Paul

Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur

"Some people dream of success... while others wake up and work hard at it" 

  

> -----Message d'origine-----
> De : linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] De la part de Dave Jones
> Envoyé : vendredi 1 avril 2005 10:00
> À : linux-kernel@vger.kernel.org
> Objet : Free Linux-like kernel sources for x86-64
> 
> Do you pine for the nice days of Linux-1.1, when men were men 
> and wrote
> their own device drivers? Are you without a nice project and 
> just dying
> to cut your teeth on a OS you can try to modify for your 
> needs? Are you
> finding it frustrating when everything works on Linux? No more all-
> nighters to get a nifty program working? Then this post might be just
> for you :-)
> 
> I'm working on a free version of a Linux-lookalike for x86-64 
> computers.
> It has finally reached the stage where it's even usable 
> (though may not be
> depending on what you want), and I am willing to put out the 
> sources for wider
> distribution.  It is just version 0.02 (+1 (very small) patch 
> already), but
> I've successfully run bash/gcc/gnu-make/gnu-sed/compress etc under it.
> 
> Sources for this pet project of mine can be found at 
> http://www.kernelslacker.org/davix
> The directory also contains some README-file and a couple of 
> binaries to work under
> Davix[*] (bash, update and gcc, what more can you ask for :-).
> 
> Full kernel source is provided.  The system is able to 
> compile "as-is" and
> has been known to work.  Heh.
> Sources to the binaries (bash and gcc) can be found at the 
> same place in
> /pub/software/.
> 
> ALERT! WARNING! NOTE! These sources still need Linux to be compiled
> (and gcc-4.0, possibly 3.x, haven't tested), and you need Linux to
> set it up if you want to run it, so it is not yet a standalone system
> for those of you without Linux. I'm working on it. You also need to be
> something of a hacker to set it up (?), so for those hoping for an
> alternative to Linux-x86-64, please ignore me. It is 
> currently meant for
> hackers interested in operating systems and x86-64's with 
> access to Linux.
> 
> The system needs an AT-compatible harddisk (IDE is fine) and 
> EGA/VGA. If
> you are still interested, please ftp the README/RELNOTES, 
> and/or mail me
> for additional info.
> 
> I can (well, almost) hear you asking yourselves "why?".  Hurd will be
> out in a year (or two, or next month, who knows), and I've already got
> Linux.  This is a program for hackers by a hacker.  I've 
> enjouyed doing
> it, and somebody might enjoy looking at it and even modifying it for
> their own needs.  It is still small enough to understand, use and
> modify, and I'm looking forward to any comments you might have.
> 
> I'm also interested in hearing from anybody who has written any of the
> utilities/library functions for Linux. If your efforts are freely
> distributable (under copyright or even public domain), I'd 
> like to hear
> from you, so I can add them to the system. I'm using Ulrich 
> Dreppers glibc
> right now (thanks for a nice and working system Uli), and 
> similar works
> will be very wellcome. Your (C)'s will of course be left 
> intact. Drop me
> a line if you are willing to let me use your code.
> 
> Davej
> 
> [*] Yes, the name sucks, but its all some other guys fault.
>     http://www.uwsg.iu.edu/hypermail/linux/kernel/9902.2/0288.html
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

