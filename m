Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131863AbQLIV4W>; Sat, 9 Dec 2000 16:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132228AbQLIV4Q>; Sat, 9 Dec 2000 16:56:16 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:58633 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S131863AbQLIV4C>; Sat, 9 Dec 2000 16:56:02 -0500
Date: Sat, 9 Dec 2000 21:25:33 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4test12pre7 pcmcia bug?
In-Reply-To: <Pine.LNX.4.10.10012091839390.31421-100000@sphinx.mythic-beasts.com>
Message-ID: <Pine.LNX.4.10.10012092124150.32648-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2000, Matthew Kirkwood wrote:

> I once managed to make it assign a socket 0 card to both sockets
> and completely ignore socket 1, but can't reproduce this now.

Did it again.  It seems that if I boot with anything
in socket 0, socket 1 becomes useless.

Matthew.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
