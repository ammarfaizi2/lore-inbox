Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265843AbTAJRaQ>; Fri, 10 Jan 2003 12:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265844AbTAJRaQ>; Fri, 10 Jan 2003 12:30:16 -0500
Received: from mail2.scram.de ([195.226.127.112]:60170 "EHLO mail2.scram.de")
	by vger.kernel.org with ESMTP id <S265843AbTAJRaP>;
	Fri, 10 Jan 2003 12:30:15 -0500
Date: Fri, 10 Jan 2003 18:37:46 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <1042219147.31848.65.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0301101833220.1492-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan 2003, Alan Cox wrote:

> On Fri, 2003-01-10 at 16:10, William Lee Irwin III wrote:
> > Any specific concerns/issues/wishlist items you want taken care of
> > before doing it or is it a "generalized comfort level" kind of thing?
> > Let me know, I'd be much obliged for specific directions to move in.
>
> IDE is all broken still and will take at least another three months to
> fix - before we get to 'improve'.

As is the whole frame buffer mess. USB slowly seems to return to a working
state. ISDN seems to be a total mess, as well.

> No more "ISAPnP TNG" and module rewrites please

Full ACK. There are still archs without working module code, right now
(parisc and mips come to my mind).

--jochen

