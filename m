Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945981AbWBCXpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945981AbWBCXpX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 18:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946004AbWBCXpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 18:45:23 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4313 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1945981AbWBCXpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 18:45:23 -0500
Date: Sat, 4 Feb 2006 00:45:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Message-ID: <20060203234504.GA3291@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602031020.46641.nigel@suspend2.net> <20060203131602.GD2972@elf.ucw.cz> <200602032341.46043.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602032341.46043.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > - Is there any way you could support doing a full image of memory with
> > > this approach? Would you take patches?
> >
> > Doing full image is certainly possible; it is not important if kernel
> > does the writing or userspace does it. Taking patches definitely
> > depends how they'd look like...
> 
> Would you actually do some work on generating them? 

Well, I'm afraid that full image of memory is not that high on
priority list. Rafael's solution seems to work pretty much okay.

> I'm concerned that I'm 
> going to end up putting more work into making patches, only to have you nack 
> them for (what seem to me like) arbitrary reasons. I feel like all you're 
> doing at the moment is pouring cold water on my work. Seeing you put
> some 

Well, sorry about that. I thought I gave you fair warning at the end
of last year, when I posted uswsusp patches to the lists...

> work into making mileage from the work I've put into Suspend2 would encourage 
> me a lot. Forgive me if I sound pretty negative - between a couple of months 
> of humid weather, lack of sleep and the event of the last few weeks, I'm not 
> in the best frame of mind at the moment. Perhaps it would be better
> for me 

Well, you did some pretty amazing work with suspend2.net community...

> just to say "I give full permission for you and Rafael to rip out of Suspend2 
> anything you find useful.", leave it at that and go find another hobby for a 
> while.

We could use some help with userland tools. Helping with userland
parts is probably the fastest way to get usable/nice/fast suspend to
the users.

If you think suspend2 can be easily ported to userspace... yes, that
would be useful/welcome.
									Pavel
-- 
Thanks, Sharp!
