Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBGJS1>; Wed, 7 Feb 2001 04:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129198AbRBGJSR>; Wed, 7 Feb 2001 04:18:17 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5394 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129032AbRBGJSE>; Wed, 7 Feb 2001 04:18:04 -0500
Subject: Re: Oopses in 2.4.1  (lots of them)
To: arthur-p@home.com (Arthur Pedyczak)
Date: Wed, 7 Feb 2001 09:18:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux kernel list)
In-Reply-To: <Pine.LNX.4.30.0102062018320.1053-100000@cs865114-a.amp.dhs.org> from "Arthur Pedyczak" at Feb 06, 2001 08:36:27 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14QQkR-0008B6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> report got ignored). After running for 4 days I got many, many oopses.
> They were trigerred by xscreensaver, and some other X-related apps.
> After dopping to runlevel 3, the system seemed O.K. Nothing unusual in
> graphics: Riva TNT2

That makes it harder to say 'Use a 3.3.6 X server'. If you are using the 
nvidia binary/obfuscated modules for their 3d and stuff try running without
them.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
