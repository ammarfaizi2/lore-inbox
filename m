Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130397AbQLXSli>; Sun, 24 Dec 2000 13:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131371AbQLXSl3>; Sun, 24 Dec 2000 13:41:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:61960 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130397AbQLXSlM>; Sun, 24 Dec 2000 13:41:12 -0500
Date: Sun, 24 Dec 2000 10:10:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Marco d'Itri" <md@Linux.IT>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <Pine.LNX.4.10.10012240941540.3972-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10012241004430.3972-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Dec 2000, Linus Torvalds wrote:
> 
> Marco, would you mind changing the test in reclaim_page(), somewheer
> around line mm/vmscan.c:487 that says:

Yeah, yeah, it's 7PM Christmas Eve over there, and you're in the middle of
your Christmas dinner. You might feel that it's unreasonable of me to ask
you to test out my latest crazy idea.

How selfish of you.

Get back there in front of the computer NOW. Christmas can wait.

		Linus "the Grinch" Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
