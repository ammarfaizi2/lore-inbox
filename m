Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130105AbRAWPD2>; Tue, 23 Jan 2001 10:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131104AbRAWPDS>; Tue, 23 Jan 2001 10:03:18 -0500
Received: from lrlug.org ([216.63.180.35]:36617 "EHLO www")
	by vger.kernel.org with ESMTP id <S130105AbRAWPDB>;
	Tue, 23 Jan 2001 10:03:01 -0500
Date: Tue, 23 Jan 2001 08:42:34 -0600 (CST)
From: Bart Dorsey <echo@thebucket.org>
To: linux-kernel@vger.kernel.org
Subject: Problem with Madge Tokenring (abyss.o) in 2.4.1-pre10
Message-ID: <Pine.LNX.4.21.0101230832550.25107-100000@www>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried to contact the driver maintainer, but his email bounced.

I constantly get this message on the console while using a Madge Smart
16/4 PCI Mk2 (Abyss) token ring card.

kernel: Warning: kfree_skb on hard IRQ d08cfea9

My quick "not knowing what I'm doing" fix was to comment out the
printk. ;)

I dunno if this is the right place to ask, but maybe the maintainer will
see this message, or perhaps someone else can pick up the ball on this
one.

Thanks,
Bart Dorsey
echo@thebucket.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
