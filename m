Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130291AbQKSVYK>; Sun, 19 Nov 2000 16:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130217AbQKSVXv>; Sun, 19 Nov 2000 16:23:51 -0500
Received: from 13dyn14.delft.casema.net ([212.64.76.14]:57358 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129799AbQKSVXh>; Sun, 19 Nov 2000 16:23:37 -0500
Message-Id: <200011192053.VAA23987@cave.bitwizard.nl>
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
In-Reply-To: <E13xXig-0002ss-00@the-village.bc.nu> from Alan Cox at "Nov 19,
 2000 04:53:32 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sun, 19 Nov 2000 21:53:14 +0100 (MET)
CC: Dan Hollis <goemon@anime.net>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone wrote:
> > > So change the CMOS-settings so that the BIOS changes the boot order
> > > from A, C, CD-ROM to C first instead.  *grin*  How long do you want
> > > to keep playing Tic-Tac-Toe?
> > 
> > Writeprotect the flashbios with the motherboard jumper, and remove the
> > cmos battery.

The "writeprotect flashbios" usually only protects the bottom 8k of
the CMOS. That's the part that you still need to boot the system to
reflash it should somehow your flash be nuked. 

			Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
