Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVBISYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVBISYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 13:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVBISYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 13:24:41 -0500
Received: from modemcable096.213-200-24.mc.videotron.ca ([24.200.213.96]:55432
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261887AbVBISYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 13:24:34 -0500
Date: Wed, 9 Feb 2005 13:24:06 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@localhost.localdomain
To: Jon Smirl <jonsmirl@gmail.com>
cc: Larry McVoy <lm@bitmover.com>, Roman Zippel <zippel@linux-m68k.org>,
       "Theodore Ts'o" <tytso@mit.edu>, Stelian Pop <stelian@popies.net>,
       Francois Romieu <romieu@fr.zoreil.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Linux Kernel Subversion Howto
In-Reply-To: <9e473391050209093856ce68bd@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0502091313350.7836@localhost.localdomain>
References: <20050208155845.GB14505@bitmover.com>  <Pine.LNX.4.61.0502081942200.6118@scrub.home>
  <20050209000733.GA6308@thunk.org>  <Pine.LNX.4.61.0502090208580.6118@scrub.home>
  <9e47339105020818242fd9f6fa@mail.gmail.com>  <Pine.LNX.4.61.0502090328490.30794@scrub.home>
  <20050209023928.GB4828@bitmover.com>  <Pine.LNX.4.61.0502090346470.30794@scrub.home>
  <20050209034030.GC4828@bitmover.com>  <Pine.LNX.4.61.0502091128070.7836@localhost.localdomain>
 <9e473391050209093856ce68bd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2005, Jon Smirl wrote:

> On Wed, 9 Feb 2005 12:17:48 -0500 (EST), Nicolas Pitre <nico@cam.org> wrote:
> > On Tue, 8 Feb 2005, Larry McVoy wrote:
> > 
> > Larry, why can't you compete only on the tool instead of claiming
> > exclusive rights on the test bench as well?
> 
> Nicolas, Larry has not said he won't make the changes that Roman
> wants, instead he has said he won't make the changes for FREE!.  There
> is a perfectly reasonable solution. Raise the funds to pay for the
> needed changes.

I'm not talking about Roman at all here.  Quoting the relevant message:

On Tue, 8 Feb 2005, Stelian Pop wrote:

> What you could make available in the bkcvs export would be, for each
> changeset (both for the changesets and for the merged changesets),
> include three BKRevs:  the changeset's one, the changeset's parent one,
> and the changeset's merge parent one.
>
> That information could be used to reconstruct the entire tree,
> using either bk-commit-head (preferred) or bkbits, provided you
> put the BKRev: tag into the bk-commit-head posts too.
>
> Technicaly speaking this should be very easy for you to implement.

I'm sure it's not the actual developer cost which is in cause here.

Larry turned it down with the usual "we're'll fear you if we do that" 
answer although I still have problems seeing why BK would be suplented 
with that info available.  The SCM problem is much much more than just a 
tree to bench test on.

So if Larry could realize that he has nothing to fear even if that info 
is available to the competition, he might even spend less time debating 
this stupid topic over and over and dedicate his time to more rentable 
activities, actually making more money as a result.


Nicolas
