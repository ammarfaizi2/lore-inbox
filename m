Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318191AbSIOTVA>; Sun, 15 Sep 2002 15:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318194AbSIOTVA>; Sun, 15 Sep 2002 15:21:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5641 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318191AbSIOTVA>; Sun, 15 Sep 2002 15:21:00 -0400
Date: Sun, 15 Sep 2002 12:26:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@arcor.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <E17qen4-00008R-00@starship>
Message-ID: <Pine.LNX.4.44.0209151220360.1393-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 15 Sep 2002, Daniel Phillips wrote:
> 
> I use UML all the time.  It's great, but it doesn't work for SMP debugging.

That should not be something fundamental, though. It should be perfectly 
doable with threading. "SMOP".

Yeah, and gdb (not to mention all the grapical nice stuff) sucks in a
threaded environment. At least it used to. 

		Linus

