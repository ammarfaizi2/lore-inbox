Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281780AbRLUNfL>; Fri, 21 Dec 2001 08:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281748AbRLUNfB>; Fri, 21 Dec 2001 08:35:01 -0500
Received: from k7g317-2.kam.afb.lu.se ([130.235.57.218]:38671 "EHLO
	cheetah.psv.nu") by vger.kernel.org with ESMTP id <S281719AbRLUNes>;
	Fri, 21 Dec 2001 08:34:48 -0500
Date: Fri, 21 Dec 2001 14:34:22 +0100 (CET)
From: Peter Svensson <petersv@psv.nu>
To: Davidovac Zoran <zdavid@unicef.org.yu>
cc: Iain McClatchie <iain@TrueCircuits.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Promise Ultra ATA 133 TX2 support for the 2.2 kernel series
In-Reply-To: <Pine.LNX.4.33.0112211300560.9786-100000@unicef.org.yu>
Message-ID: <Pine.LNX.4.33.0112211432280.1086-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2001, Davidovac Zoran wrote:

> You can find ATA patches in
> 
> ftp.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.19
> 
>  ide.2.2.19.05042001...> 15-May-2001 14:32   185k  Source code patch
> 
> I am using it long time and it is stable,
> note you will have to patch k2.2.20 manual

Does this patch support lba48 commands? For which ide adapters? (I read an 
announcement from Intel that with a patch and a new driver their i8xx 
chipsets could use lba48. 

Specifically, I am interested in the Promise ATA100 cards since I own one. 

Peter
--
Peter Svensson      ! Pgp key available by finger, fingerprint:
<petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
------------------------------------------------------------------------
Remember, Luke, your source will be with you... always...


