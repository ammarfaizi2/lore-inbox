Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317152AbSEXPae>; Fri, 24 May 2002 11:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317154AbSEXPad>; Fri, 24 May 2002 11:30:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48140 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317152AbSEXPac>; Fri, 24 May 2002 11:30:32 -0400
Subject: Re: Quota patches
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Fri, 24 May 2002 16:43:47 +0100 (BST)
Cc: jack@suse.cz (Jan Kara), nathans@sgi.com (Nathan Scott),
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        hirofumi@mail.parknet.co.jp (OGAWA Hirofumi),
        linux-kernel@vger.kernel.org
In-Reply-To: <3CEE49C3.4050202@evision-ventures.com> from "Martin Dalecki" at May 24, 2002 04:10:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BHEJ-0006ed-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If we can do it for quota - we could possible remove the
> IPC_OLD variant away as well. It's looong overdue by now,
> becouse the IPC_OLD was not standard conformant anyway.
> 
> I would be really really glad to do it iff ACK-ed.

More code that takes almost no space, ensures old systems still work and 
old XFree86 still runs on new kernels. Why remove it ?

If you want to design a mathematically elegant and small ultra clean OS go
do it. Linux however has to work in the real world not in the happy clueless
world of pure mathematical elegance
