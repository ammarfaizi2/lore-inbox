Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131471AbQJ2Avy>; Sat, 28 Oct 2000 20:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131486AbQJ2Avo>; Sat, 28 Oct 2000 20:51:44 -0400
Received: from DKBH-T-003-p-249-142.tmns.net.au ([203.54.249.142]:42507 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S131471AbQJ2Avf>;
	Sat, 28 Oct 2000 20:51:35 -0400
Message-ID: <39FB72A9.DB3E66BB@eyal.emu.id.au>
Date: Sun, 29 Oct 2000 11:43:21 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ide-patch for 2.2.18(pre)
In-Reply-To: <Pine.LNX.4.21.0010280032200.9401-100000@tricky>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> 
> I have ported ide-patch to 2.2.18-17 and I'm now backporting
> 2.4.0 changes. New VIA, SLC, OSB4 drivers and MANY other things
> are already there.I hope that final 2.2.18-ide-patch will have
> IDE functionality equal to this in 2.4.0-test10...
> 
> Here is a snapshot (it's not thoroughly audited and tested):
>         http://republika.pl/bkz/ide.2.2.18-17.all.20001027.patch.bz2
> 
> And please cut that bullshit about ide-patch 2.2.x being unmantained.
> I don't use 2.2.x kernels anymore so I don't do ide-patches for pre
> kernels. But there will be patches for stable 2.2.x. (Although it's
> a real pain - I hate doing backporting instead of new stuff).

Can you say something about how well it patches (and behaves) with
the corresponding RAID patch, e.g.

http://www.kernel.org/pub/linux/kernel/people/mingo/raid-patches/raid-2.2.18-A2

--
Eyal Lebedinsky		(eyal@eyal.emu.id.au)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
