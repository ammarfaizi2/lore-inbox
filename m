Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318218AbSIOTHH>; Sun, 15 Sep 2002 15:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318219AbSIOTHG>; Sun, 15 Sep 2002 15:07:06 -0400
Received: from dsl-213-023-020-240.arcor-ip.net ([213.23.20.240]:10624 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318218AbSIOTHF>;
	Sun, 15 Sep 2002 15:07:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Date: Sun, 15 Sep 2002 21:10:41 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209151206440.1200-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0209151206440.1200-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qen4-00008R-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 September 2002 21:08, Linus Torvalds wrote:
> On Sun, 15 Sep 2002, Linus Torvalds wrote:
> 
> > ... or are at least capable to add a patch on their own.
> 
> Actually, in BK-current you don't even need to do that, as UML has been 
> integrated into 2.5.x for a few days now.
> 
> I'll make a 2.5.35 later today, assuming no new threading bugs crop up. 
> And then you can use a debugger on a bog-standard kernel, and maybe this 
> issue won't come up ever again.
> 
> Yeah, right.

I use UML all the time.  It's great, but it doesn't work for SMP debugging.

By the way, thanks much for integrating UML.

-- 
Daniel
