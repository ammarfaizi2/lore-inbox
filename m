Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132530AbQKSPlb>; Sun, 19 Nov 2000 10:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132522AbQKSPlV>; Sun, 19 Nov 2000 10:41:21 -0500
Received: from anime.net ([63.172.78.150]:525 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S132536AbQKSPlF>;
	Sun, 19 Nov 2000 10:41:05 -0500
Date: Sun, 19 Nov 2000 07:11:15 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: <linux-kernel@vger.kernel.org>
cc: David Lang <david.lang@digitalinsight.com>, <kraxel@bytesex.org>
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
In-Reply-To: <Pine.GSO.4.21.0011190944330.22734-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0011190710440.13087-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2000, Alexander Viro wrote:
> On Sun, 19 Nov 2000, David Lang wrote:
> > there is a rootkit kernel module out there that, if loaded onto your
> > system, can make it almost impossible to detect that your system has been
> > compramised. with module support disabled this isn't possible.
> Yes, it is. Easily. If you've got root you can modify the kernel image and
> reboot the bloody thing. And no, marking it immutable will not help. Open
> the raw device and modify relevant blocks.

Kernel on writeprotected floppy disk...

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
