Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131624AbRABUXo>; Tue, 2 Jan 2001 15:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131754AbRABUXf>; Tue, 2 Jan 2001 15:23:35 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15876 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131624AbRABUXQ>; Tue, 2 Jan 2001 15:23:16 -0500
Subject: Re: Chipsets, DVD-RAM, and timeouts....
To: andre@linux-ide.org (Andre Hedrick)
Date: Tue, 2 Jan 2001 19:53:08 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        hakanl@cdt.luth.se (Hakan Lennestal),
        dwmw2@infradead.org (David Woodhouse), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101021139450.26680-100000@master.linux-ide.org> from "Andre Hedrick" at Jan 02, 2001 11:44:57 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14DXUd-0002mx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It sounds like the proper fix would be to not enable ata66 by default.
> 
> LT,
> 
> This is one of the evolution timing issues that both the drive guys and
> the chipset guys point fingers, while both attempt to fix the problem in
> their BIOS/Diskware.

Then lets default to ATA33 on the problem kit. It'll encourage them to sort it
out as everyone will get better results on other stuff 8)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
