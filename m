Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263753AbTJCPpM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 11:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbTJCPpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 11:45:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:30084 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263753AbTJCPpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 11:45:08 -0400
Date: Fri, 3 Oct 2003 08:36:40 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Matthew Wilcox <willy@debian.org>
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: must-fix list reconciliation
Message-Id: <20031003083640.61dcf517.rddunlap@osdl.org>
In-Reply-To: <20031003113437.GL24824@parcelfarce.linux.theplanet.co.uk>
References: <3F7D3F37.1060005@cyberone.com.au>
	<20031003113437.GL24824@parcelfarce.linux.theplanet.co.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Oct 2003 12:34:37 +0100 Matthew Wilcox <willy@debian.org> wrote:

| On Fri, Oct 03, 2003 at 07:19:51PM +1000, Nick Piggin wrote:
| > Hi everyone,
| > As you might or might not know, the must-fix / should-fix lists have been
| > inadvertently forked. We are merging them again, so please don't update
| > the wiki until we have worked out what to do with them. This should be a
| > day or two at most.
| > 
| > I had the idea that maybe we could put them into the source tree, and
| > encourage people to keep them up to date by making them become criteria
| > for the feature and code freeze. Comments?
| 
| I'm a little disappointed that after I spent time converting them into
| the wiki form, you're now proposing abandoning them again.  This seems
| like a retrograde step.
| 
| What I'd be more interested in doing is combining the must- and should-
| fix lists.  As a first pass, just put all the must-fix items on the
| should-fix list at pri 4.  One of the things I did was delete the things
| that appeared on both lists.  This would obviously be easier if they
| were in one list ;-)

Agreed on that.  I think the location is not the problem (whether
source tree or wiki), it's just an extra step to keep them updated,
and having no owner (or _many_ owners) often doesn't work.
Is one of you (or the two of you) willing to be the owner/editor?

--
~Randy
