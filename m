Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311523AbSDQSIL>; Wed, 17 Apr 2002 14:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311530AbSDQSIK>; Wed, 17 Apr 2002 14:08:10 -0400
Received: from bitmover.com ([192.132.92.2]:42181 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S311523AbSDQSIK>;
	Wed, 17 Apr 2002 14:08:10 -0400
Date: Wed, 17 Apr 2002 11:08:09 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB device support for 2.5.8 (take 2)
Message-ID: <20020417110809.R745@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <074401c1e629$0a9ea020$6800000a@brownell.org> <Pine.LNX.4.33.0204171043260.17271-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 10:57:21AM -0700, Linus Torvalds wrote:
> Since we're talking about the other end of a "host" driver, "client" makes
> sense - in computers, I've always seen "client" as the reverse of the
> "host", but maybe that's just me. Outside of computers, "guest" seems to
> be the proper antonym, but that just strikes me as bizarre (a "USB guest
> driver"?)

What about "target"?  In SCSI land, it's clear that a target is the device,
and when you talk about code that runs on a computer and makes it be a 
SCSI target, everyone knows what you mean, right?  So what about code that
makes a computer a USB target?  Would that work?  That's the only thing I
could think of that was similar.  Does USB already use the term target for
something else?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
