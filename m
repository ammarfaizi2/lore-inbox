Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130371AbQLIJ2J>; Sat, 9 Dec 2000 04:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129959AbQLIJ17>; Sat, 9 Dec 2000 04:27:59 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:21256 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130371AbQLIJ1v>; Sat, 9 Dec 2000 04:27:51 -0500
Date: Sat, 9 Dec 2000 00:56:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: David Woodhouse <dwmw2@infradead.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7 
In-Reply-To: <Pine.LNX.4.10.10012082356020.2121-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10012090054360.791-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Dec 2000, Linus Torvalds wrote:
> 
> This is a preliminary patch that I have not compiled and probably breaks,
> but you get the idea. I'm going to sleep, to survive another night with
> three small kids.

Call me stupid [ Chorus: "You're stupid, Linus" ], but I actually compiled
and booted this remotely. And it came up. Which is a pretty good sign that
it doesn't have anything really broken in it.

Still, it would be good to have a few other sharp eyes looking it over.
Look sclean and obviously correct to me, but then _everything_ I write
always looks obviously correct yo me.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
