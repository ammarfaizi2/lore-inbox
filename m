Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268068AbRGVVf5>; Sun, 22 Jul 2001 17:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268070AbRGVVfr>; Sun, 22 Jul 2001 17:35:47 -0400
Received: from femail21.sdc1.sfba.home.com ([24.0.95.146]:25236 "EHLO
	femail21.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S268068AbRGVVfi>; Sun, 22 Jul 2001 17:35:38 -0400
Message-ID: <3B5B4756.4B1E6022@home.com>
Date: Sun, 22 Jul 2001 16:36:22 -0500
From: Steven Lass <stevenlass1@home.com>
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: bug: 2.4.[<=6] kernel has Cyrix 'coma' bug?
In-Reply-To: <3B5AD0DF.8DDC5D1E@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Just tried the 2.4.7 kernel & it freezes too.

-steve

Steven Lass wrote:
> 
> dev-list,
> 
> Every 2.4 kernel that I've tried freezes my Cyrix MediaGX system at boot
> up.
> 
> Typically the last messages displayed are:
> 
> Working around Cyrix MediaGX virtual DMA bugs
> CPU: Cyrix Media GX Core/Bus Clock Stepping 02
> Checking 'hlt' instruction
> 
> Occasionally, the "Checking 'hlt' instruction" is not displayed before
> it freezes.
> 
> My system is a PowerSpec Model 1810 (no laughs please), my Phoenix BIOS
> reports "Cyrix GX 3.2 180MHz".
> 
> I've compiled/installed numerous 2.2.x kernels w/o any trouble.  The
> Redhat 7.1 CDROM image freezes at boot.  I've compiled the 2.4.4, 2.4.5,
> & 2.4.6 kernels with various config settings, but they all freeze at
> boot.  I'm currently running redhat 7.0, so I've tried compiling with
> gcc (gcc 2.96 20000731) & kgcc (egcs 1.1.2 release), no luck.
> 
> I'm willing to compile the 2.4.[<4} kernels or try any other
> pre-compiled kernels if anyone has a suggestion.
> 
> Please CC: me on any response
> -steve
