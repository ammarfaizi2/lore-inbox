Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129843AbRBKRJI>; Sun, 11 Feb 2001 12:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbRBKRI6>; Sun, 11 Feb 2001 12:08:58 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60940 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129843AbRBKRIp>; Sun, 11 Feb 2001 12:08:45 -0500
Subject: Re: [OT] Major Clock Drift
To: pavel@suse.cz (Pavel Machek)
Date: Sun, 11 Feb 2001 17:07:51 +0000 (GMT)
Cc: teastep@seattlefirewall.dyndns.org (Tom Eastep),
        fd0man@crosswinds.net (Michael B. Trausch),
        jbm@joshisanerd.com (Josh Myer), linux-kernel@vger.kernel.org
In-Reply-To: <20010210225807.F7877@bug.ucw.cz> from "Pavel Machek" at Feb 10, 2001 10:58:07 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Rzyc-0004SB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, I can make it loose 30 seconds in 12 seconds. Just cat
> /etc/termcap. Vesafb does this kind of stuff. [Yes, 3 times slower
> clock].

Why are interrupts being disabled for vesafb scrolling anyway ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
