Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132549AbQKSRYh>; Sun, 19 Nov 2000 12:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132417AbQKSRY2>; Sun, 19 Nov 2000 12:24:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24352 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129716AbQKSRYR>; Sun, 19 Nov 2000 12:24:17 -0500
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
To: goemon@anime.net (Dan Hollis)
Date: Sun, 19 Nov 2000 16:53:32 +0000 (GMT)
Cc: wingel@hog.ctrl-c.liu.se (Christer Weinigel), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0011190740290.13294-100000@anime.net> from "Dan Hollis" at Nov 19, 2000 07:50:39 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13xXig-0002ss-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So change the CMOS-settings so that the BIOS changes the boot order
> > from A, C, CD-ROM to C first instead.  *grin*  How long do you want
> > to keep playing Tic-Tac-Toe?
> 
> Writeprotect the flashbios with the motherboard jumper, and remove the
> cmos battery.
> 
> Checkmate. :-)

You can do a live Linux kernel swap without a bios level reboot. 

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
