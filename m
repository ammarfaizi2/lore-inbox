Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbTCXXta>; Mon, 24 Mar 2003 18:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbTCXXta>; Mon, 24 Mar 2003 18:49:30 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12050 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261206AbTCXXt2>; Mon, 24 Mar 2003 18:49:28 -0500
Date: Tue, 25 Mar 2003 01:00:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: CaT <cat@zip.com.au>
Cc: Andrew Morton <akpm@digeo.com>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.65: *huge* interactivity problems
Message-ID: <20030325000035.GC3539@atrey.karlin.mff.cuni.cz>
References: <20030323231306.GA4704@elf.ucw.cz> <20030324171936.680f98e2.akpm@digeo.com> <20030324234556.GK621@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324234556.GK621@zip.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'm having awfull interactivity problems. While lingvistic application
> > > (slm from nltools.sf.net) is running, machine is unusable. I still can
> > > read text in most, but can't login, can't run links, can't... For
> > > minutes.
> > > 
> > > slm does a lot of computation over ~250MB dataset, but during stall
> > > disk was not active.
> > 
> > Oh Pavel, this is more a whinge than a bug report.  You know better ;)
> 
> If he's seeing what I'm seeing then I can put my own answers to this. I
> get freezups, lost keystrokes and eventual shutdown of the laptop. I can
> reproduce it prettymuch at will be it a compilation of a piece of s/w,
> the kernel, mozilla loading pages or whatnot.

Actually, this looks like unrelated problem. I'm not getting lost
keystrokes, and machine recovers after lingvistics computation
finishes.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
