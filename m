Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318148AbSIOSBK>; Sun, 15 Sep 2002 14:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318151AbSIOSBK>; Sun, 15 Sep 2002 14:01:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25606 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318148AbSIOSBJ>; Sun, 15 Sep 2002 14:01:09 -0400
Date: Sun, 15 Sep 2002 11:06:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@arcor.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <E17qRfU-0001qz-00@starship>
Message-ID: <Pine.LNX.4.44.0209151103170.10830-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 15 Sep 2002, Daniel Phillips wrote:
> 
> Let's try a different show of hands: How many users would be happier if
> they knew that kernel developers are using modern techniques to improve
> the quality of the kernel?

You're all talk and no action.

The last time I looked, the people who really _do_ improve the quality of
the kernel don't tend to care too much about debuggers, or are at least
capable to add a patch on their own.

In fact, of the people who opened their mouth about the BUG() issue, how 
many actually ended up personally _debugging_ the BUG() that we were 
talking about?

I did. Matt probably did. But I didn't see you fixing it with your
debugger.

So next time you bring up the kernel debugger issue, show some code and 
real improvement first. Until then, don't spout off.

		Linus

