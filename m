Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277188AbRJDSM1>; Thu, 4 Oct 2001 14:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277182AbRJDSMR>; Thu, 4 Oct 2001 14:12:17 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39437 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273724AbRJDSMK>; Thu, 4 Oct 2001 14:12:10 -0400
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 4 Oct 2001 19:16:32 +0100 (BST)
Cc: greearb@candelatech.com (Ben Greear), hadi@cyberus.ca (jamal),
        mingo@elte.hu (Ingo Molnar), linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru (Alexey Kuznetsov),
        Robert.Olsson@data.slu.se (Robert Olsson),
        bcrl@redhat.com (Benjamin LaHaise), netdev@oss.sgi.com,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.33.0110030920500.9427-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 03, 2001 09:33:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pD2u-0003ae-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  (a) is not a major security issue. If you allow untrusted users full
>      100/1000Mbps access to your internal network, you have _other_
>      security issues, like packet sniffing etc that are much much MUCH
>      worse. So the packet flooding thing is very much a corner case, and
>      claiming that we have a big problem is silly.

Not nowdays. 100Mbit pipes to the backbone are routine for web serving in
the real world - at least the paying end (aka porn).

Alan
