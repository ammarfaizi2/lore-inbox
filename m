Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129824AbRBFCaD>; Mon, 5 Feb 2001 21:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136298AbRBFC3x>; Mon, 5 Feb 2001 21:29:53 -0500
Received: from r67h147.res.gatech.edu ([128.61.67.147]:31236 "HELO
	kermit.wreck.org") by vger.kernel.org with SMTP id <S130869AbRBFC3l>;
	Mon, 5 Feb 2001 21:29:41 -0500
Date: Mon, 5 Feb 2001 21:29:39 -0500 (EST)
From: Misc Mail for Erich <junkmail@wreck.org>
To: linux-kernel@vger.kernel.org
Subject: FA-311 / Natsemi problems with 2.4.1
Message-ID: <Pine.LNX.4.21.0101310919330.7723-100000@kermit.wreck.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having problems with the natsemi drivers on my Netgear FA-311 card.

On one host, I get lots of messages like this:

eth1: Something Wicked happened! 0700.
eth1: Something Wicked happened! 0740.
eth1: Something Wicked happened! 0740.
eth1: Something Wicked happened! 0740.
eth1: Something Wicked happened! 0740.
eth1: Something Wicked happened! 0740.
eth1: Something Wicked happened! 0540.

This is on a K6-166

On my athlon/duron, I don't get those messages, but once in a while it will 
just stop working.  If I bring the interface down, remove the module, and 
bring the interface back up again it will start to work again.

These two cards are connected by a crossover cable.  When the cards are 
working the link works just fine.

What more information do I need to obtain?  Please cc me, though I'll
be watching the list archives as well.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
