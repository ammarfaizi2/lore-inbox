Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132564AbQKSQUd>; Sun, 19 Nov 2000 11:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132579AbQKSQUY>; Sun, 19 Nov 2000 11:20:24 -0500
Received: from anime.net ([63.172.78.150]:9997 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S132564AbQKSQUQ>;
	Sun, 19 Nov 2000 11:20:16 -0500
Date: Sun, 19 Nov 2000 07:50:39 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Christer Weinigel <wingel@hog.ctrl-c.liu.se>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
In-Reply-To: <20001119150837.8EF2737237@hog.ctrl-c.liu.se>
Message-ID: <Pine.LNX.4.30.0011190740290.13294-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2000, Christer Weinigel wrote:
> In article <Pine.LNX.4.30.0011190710440.13087-100000@anime.net> you write:
> >On Sun, 19 Nov 2000, Alexander Viro wrote:
> >> On Sun, 19 Nov 2000, David Lang wrote:
> >> > there is a rootkit kernel module out there that, if loaded onto your
> >> > system, can make it almost impossible to detect that your system has been
> >> > compramised. with module support disabled this isn't possible.
> >> Yes, it is. Easily. If you've got root you can modify the kernel image and
> >> reboot the bloody thing. And no, marking it immutable will not help. Open
> >> the raw device and modify relevant blocks.
> >Kernel on writeprotected floppy disk...
> So change the CMOS-settings so that the BIOS changes the boot order
> from A, C, CD-ROM to C first instead.  *grin*  How long do you want
> to keep playing Tic-Tac-Toe?

Writeprotect the flashbios with the motherboard jumper, and remove the
cmos battery.

Checkmate. :-)

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
