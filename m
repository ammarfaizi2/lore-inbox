Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318205AbSIOTD1>; Sun, 15 Sep 2002 15:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318207AbSIOTD1>; Sun, 15 Sep 2002 15:03:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29704 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318205AbSIOTD0>; Sun, 15 Sep 2002 15:03:26 -0400
Date: Sun, 15 Sep 2002 12:08:23 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@arcor.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <Pine.LNX.4.44.0209151103170.10830-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209151206440.1200-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 15 Sep 2002, Linus Torvalds wrote:

> ... or are at least capable to add a patch on their own.

Actually, in BK-current you don't even need to do that, as UML has been 
integrated into 2.5.x for a few days now.

I'll make a 2.5.35 later today, assuming no new threading bugs crop up. 
And then you can use a debugger on a bog-standard kernel, and maybe this 
issue won't come up ever again.

Yeah, right.

		Linus

