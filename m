Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWCILqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWCILqO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWCILqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:46:14 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29095 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750827AbWCILqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:46:13 -0500
Date: Thu, 9 Mar 2006 12:45:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: Thomas Maier <Thomas.Maier@uni-kassel.de>, linux-kernel@vger.kernel.org
Subject: Re: [Suspend2-announce] Nigel's work and the future of Suspend2.
Message-ID: <20060309114556.GE2813@elf.ucw.cz>
References: <200603071005.56453.nigel@suspend2.net> <1141737241.5386.28.camel@marvin.se.eecs.uni-kassel.de> <20060308122500.GB3274@elf.ucw.cz> <1141903990.1745.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141903990.1745.5.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > Mainline swsusp never worked for me and
> > > so with you leaving I am tempted to leave Linux behind after more than
> > > ten years and switch to that other OS that at least has working suspend
> > > and resume.  
> didnt work on my laptop either, or one of my friends where i tried..
> however, swsusp2 does..

bugzilla IDs?

> > Your choice... But it would be more productive to read the docs, go to
> > the latest kernel, and if it does not work there, file
> > bugzilla.kernel.org report.
> yeah well.. IMO merging suspend2 is more productive, as i see it, it has
> no downsides as to software suspend as of now, except IA64 support, and
> it has ALOT of upsides.

Except that suspend2 is not going to be merged, for variety of
reasons. One of them is that noone is working on merging it...

So yes, filling bugzilla entries would be more productive than flaming
me.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
