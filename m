Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129500AbRBGSfN>; Wed, 7 Feb 2001 13:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129674AbRBGSfE>; Wed, 7 Feb 2001 13:35:04 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15877 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129500AbRBGSex>; Wed, 7 Feb 2001 13:34:53 -0500
Subject: Re: Oopses in 2.4.1  (lots of them)
To: arthur-p@home.com (Arthur Pedyczak)
Date: Wed, 7 Feb 2001 18:35:45 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux kernel list)
In-Reply-To: <Pine.LNX.4.30.0102070735590.4661-100000@cs865114-a.amp.dhs.org> from "Arthur Pedyczak" at Feb 07, 2001 07:50:28 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14QZRU-0000xJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> am not sure how to eliminate or confirm this. Recently I added some RAM
> (256->384) and decided to get rid of swap. This seemed to have destabilized
> the system, although nothing is obvious. I can try to stress the system by

Get a copy of memtest86, its a standalone memory tester.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
