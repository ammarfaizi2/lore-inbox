Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267442AbTB1DVR>; Thu, 27 Feb 2003 22:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267443AbTB1DVR>; Thu, 27 Feb 2003 22:21:17 -0500
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:16779 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S267442AbTB1DVQ>; Thu, 27 Feb 2003 22:21:16 -0500
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200302280330.h1S3U6Uw008613@wildsau.idv.uni.linz.at>
Subject: Re: emm386 hangs when booting from linux
In-Reply-To: <200302280318.h1S3IoxM008387@wildsau.idv.uni.linz.at> from "H.Rosmanith" at "Feb 28, 3 04:18:50 am"
To: kernel@wildsau.idv.uni.linz.at (H.Rosmanith)
Date: Fri, 28 Feb 2003 04:30:06 +0100 (MET)
Cc: linux-kernel@vger.kernel.org, herp@wildsau.idv.uni.linz.at
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> "machine_real_restart" is in <arch/i386/kernel/process.c> - possibly
> it forgets to reset something particular in the cpu/mmu...and later on,
> emm386.exe will hang the system. Interestingly, DOS4GW will *not* hang
> the system and vertex-inducing games like doom & co. will work like
                 ^^^^^^
                      read: "vertigo-inducing games" I've been doing
too much computer graphics today ;-)

thanks,
herp

