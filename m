Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWE1WDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWE1WDX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 18:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWE1WDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 18:03:23 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:7571 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750983AbWE1WDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 18:03:22 -0400
Subject: Re: How to check if kernel sources are installed on a system?
From: Lee Revell <rlrevell@joe-job.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       devmazumdar <dev@opensound.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060528215504.GS13513@lug-owl.de>
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe>
	 <1148653797.3579.18.camel@laptopd505.fenrus.org>
	 <20060528130320.GA10385@osiris.ibm.com>
	 <1148835799.3074.41.camel@laptopd505.fenrus.org>
	 <1148838738.21094.65.camel@mindpipe>
	 <1148839964.3074.52.camel@laptopd505.fenrus.org>
	 <1148846131.27461.14.camel@mindpipe> <20060528204558.GR13513@lug-owl.de>
	 <1148851660.27461.23.camel@mindpipe>  <20060528215504.GS13513@lug-owl.de>
Content-Type: text/plain
Date: Sun, 28 May 2006 18:02:53 -0400
Message-Id: <1148853773.28334.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-28 at 23:55 +0200, Jan-Benedict Glaw wrote:
> On Sun, 2006-05-28 17:27:39 -0400, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Sun, 2006-05-28 at 22:45 +0200, Jan-Benedict Glaw wrote:
> > > ...which isn't always the worst solution to the problem. If some guy
> > > doesn't want to jump through the loops to figure out what's actually
> > > broken, Windows may be a good solution for them. "World domination"
> > > also means "dominated by the world's problems," so I tend to go a step
> > > back from time to time:-)
> > 
> > Yes, if it were a perfect world and we had access to all the hardware
> > specs like Microsoft does, we would not need these users' help.  But the
> > users have access to a lot more hardware than the developers do and
> > trial and error is often the only solution.
> 
> But this isn't a perfect world.
> 

Uhmmm... that was my point.  Please re-read my post.

> > If they give up and go back to Windows we may never support their
> > hardware correctly.
> 
> No user for that given hardware, then there's no sense in supporting
> it.

Chicken and egg problem.  Users have hardware and they want to run Linux
on it.  It's not always feasible for them to verify Linux compatibility
before they buy.  And some vendors like BenQ even ship a Linux CD with
their laptops even though the sound doesn't work on any BenQ system -
they obviously did not even try it.  So we have a large population of
users who would love to run Linux but can't until we support their
hardware.

>  If there's a user that *really* wants that hardware supported,
> then they will put effort into getting it to work, either by helping
> debugging, hacking or by paying some expert to reverse-engineer an
> existing driver.

There are many users who *really* want their hardware supported but
don't have the funds or the know-how to do any of these.  Like all of
these users:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1134

Lee

