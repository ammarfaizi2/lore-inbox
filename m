Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262246AbSIPPZO>; Mon, 16 Sep 2002 11:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262267AbSIPPZO>; Mon, 16 Sep 2002 11:25:14 -0400
Received: from waste.org ([209.173.204.2]:11985 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262246AbSIPPZN>;
	Mon, 16 Sep 2002 11:25:13 -0400
Date: Mon, 16 Sep 2002 10:29:29 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@arcor.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020916152929.GC27805@waste.org>
References: <Pine.LNX.4.44.0209151103170.10830-100000@home.transmeta.com> <Pine.LNX.4.44.0209151206440.1200-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209151206440.1200-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2002 at 12:08:23PM -0700, Linus Torvalds wrote:
> 
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

Given that most of the codebase is in drivers (never mind non-UML
supported arches), that's a little unlikely...

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
