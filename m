Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317851AbSIOF2r>; Sun, 15 Sep 2002 01:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317852AbSIOF2r>; Sun, 15 Sep 2002 01:28:47 -0400
Received: from mail.gipiproject.org ([206.112.85.61]:64472 "EHLO mail.cdt.org")
	by vger.kernel.org with ESMTP id <S317851AbSIOF2p>;
	Sun, 15 Sep 2002 01:28:45 -0400
Date: Sun, 15 Sep 2002 01:33:37 -0400 (EDT)
From: Daniel Berlin <dberlin@dberlin.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <E17qRfU-0001qz-00@starship>
Message-ID: <Pine.LNX.4.44.0209150118220.25197-100000@dberlin.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 Sep 2002, Daniel Phillips wrote:

> On Tuesday 10 September 2002 21:03, Linus Torvalds wrote:
> > On 10 Sep 2002, Alan Cox wrote:
> > > 
> > > It drops you politely into the kernel debugger, you fix up the values
> > > and step over it. If you want to debug with zen mind power and printk
> > > feel free. For the rest of us BUG() is fine on SMP
> > 
> > Ok, a show of hands.. 
> > 
> > Of the millions (whatever) of Linux machines, how many have a kernel 
> > debugger attached? Count them.
> 
> Eh, mine is getting one attached to it right now. 

Me too.

> It's getting more
> popular, and it would be more popular yet if it weren't considered some
> dirty little secret, or somehow unmanly.

Reminds me of "Suns boot fast" (do a google search on it, and read the 
first thing that comes up).

> 
> Let's try a different show of hands: How many users would be happier if
> they knew that kernel developers are using modern techniques to improve
> the quality of the kernel?
> 
> Of course, I use the term "modern" here loosely, since kdb and kgdb are
> really only 80's technology.  Without them, we're stuck in the 60's.
Moving from the stone to the bronze age, one day at a time.


> 
> 

