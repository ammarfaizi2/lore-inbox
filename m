Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276591AbRKMQsO>; Tue, 13 Nov 2001 11:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276647AbRKMQr7>; Tue, 13 Nov 2001 11:47:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34058 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276576AbRKMQrK>; Tue, 13 Nov 2001 11:47:10 -0500
Subject: Re: GPLONLY kernel symbols???
To: davej@suse.de (Dave Jones)
Date: Tue, 13 Nov 2001 16:54:27 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        rgooch@ras.ucalgary.ca (Richard Gooch),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.30.0111131439420.4157-100000@Appserv.suse.de> from "Dave Jones" at Nov 13, 2001 02:47:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163gpP-0001fF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, hpa and myself are the only ones really maintaining it
> in the last two years judging from the changelog. Some others
> probably also contributed small changes not worthy of an entry.

Or rewrote the Winchip code but didnt feel egotistical enough

> I got the idea a while ago that splitting the various implementations
> (Cyrix/K6/etc) out to seperate files would be a good start.
> After I ripped it apart for an x86-64 version (not-yet-tested/merged),
> I realised it still needs more work.

I looked at that - but its hard to see the right places to split it
