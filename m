Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUCAKjt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 05:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbUCAKjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 05:39:49 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43703 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261183AbUCAKjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 05:39:47 -0500
Date: Mon, 1 Mar 2004 11:39:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: M?ns Rullg?rd <mru@kth.se>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Dropping CONFIG_PM_DISK?
Message-ID: <20040301103946.GA9171@atrey.karlin.mff.cuni.cz>
References: <1ulUA-33w-3@gated-at.bofh.it> <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz> <yw1x4qt93i6y.fsf@kth.se> <20040229181053.GD286@elf.ucw.cz> <yw1xznb120zn.fsf@kth.se> <20040301094023.GF352@elf.ucw.cz> <yw1xhdx8ani6.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xhdx8ani6.fsf@kth.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > Try current swsusp with minimal drivers, init=/bin/bash.
> >> 
> >> Well, if I do that it works.  Or at least some old version did, I
> >> assume the later ones would too.  However, that sort of removes the
> >> whole point.  Taking down the system enough to be able to unload
> >> almost everything is as close as rebooting you'll get.
> >
> > Well, now do a search for "which module/application causes failure".
> 
> I know, it just takes an awful time.

Binary search should be pretty fast.

> >> BTW, is there some easier way to track the development than using the
> >> patches from the web page?  Unpatching after a couple of BK merges
> >> isn't the easiest thing.  Is there a BK tree somewhere I can pull
> >> from?
> >
> > Are you using swsusp2?
> 
> Well, trying to.  Isn't it supposed to be the latest and greatest?

It is latest, but not most stable.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
