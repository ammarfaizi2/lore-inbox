Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317799AbSIOFDk>; Sun, 15 Sep 2002 01:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317816AbSIOFDk>; Sun, 15 Sep 2002 01:03:40 -0400
Received: from dsl-213-023-043-058.arcor-ip.net ([213.23.43.58]:57504 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317799AbSIOFDj>;
	Sun, 15 Sep 2002 01:03:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Date: Sun, 15 Sep 2002 07:10:00 +0200
X-Mailer: KMail [version 1.3.2]
Cc: David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qRfU-0001qz-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 September 2002 21:03, Linus Torvalds wrote:
> On 10 Sep 2002, Alan Cox wrote:
> > 
> > It drops you politely into the kernel debugger, you fix up the values
> > and step over it. If you want to debug with zen mind power and printk
> > feel free. For the rest of us BUG() is fine on SMP
> 
> Ok, a show of hands.. 
> 
> Of the millions (whatever) of Linux machines, how many have a kernel 
> debugger attached? Count them.

Eh, mine is getting one attached to it right now.  It's getting more
popular, and it would be more popular yet if it weren't considered some
dirty little secret, or somehow unmanly.

Let's try a different show of hands: How many users would be happier if
they knew that kernel developers are using modern techniques to improve
the quality of the kernel?

Of course, I use the term "modern" here loosely, since kdb and kgdb are
really only 80's technology.  Without them, we're stuck in the 60's.

-- 
Daniel
