Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.com) by vger.kernel.org via listexpand
	id <S261159AbRELD7q>; Fri, 11 May 2001 23:59:46 -0400
Received: (majordomo@vger.kernel.com) by vger.kernel.org
	id <S261176AbRELD7F>; Fri, 11 May 2001 23:59:05 -0400
Received: from zeus.kernel.org ([209.10.41.242]:49800 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261167AbRELD6F>;
	Fri, 11 May 2001 23:58:05 -0400
Message-Id: <200105120305.WAA05281@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org
cc: cemerson@chiark.greenend.org.uk
Subject: Re: User-mode Linux ported to ppc 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 May 2001 22:05:25 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cemerson@chiark.greenend.org.uk said:
> User-mode Linux is now booting on PPC Linux - it can boot with a
> Debian root floppy image with init=/bin/sh and poke around.  It mostly
> works, although there are still a few problems.

First off, I'd like to thank Chris for volunteering to undertake the first 
port of UML and seeing it through to the point where it's basically working.  
It's a nice demonstration, if any were needed, that UML isn't i386-only.

Based on what I've learned from this port, I'm writing up what amounts to a 
UML porting guide.  It will be found at http://user-mode-linux.sourceforge.net/
arch-port.html when I have something ready.  It will be incomplete at first - 
I'll be filling it in as I go through the existing code and as I finish 
integrating Chris's code into my pool.

So, if anyone wants to port UML to another arch, have a look at that page (and 
continue looking as I fill it in :-).  You'll see that it's not a huge amount 
of work.  UML is fairly portable.

				Jeff


