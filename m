Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbWBHXAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWBHXAE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWBHXAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:00:04 -0500
Received: from xenotime.net ([66.160.160.81]:9370 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030287AbWBHXAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:00:02 -0500
Date: Wed, 8 Feb 2006 15:00:01 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Linda Walsh <lkml@tlinx.org>
cc: "Luck, Tony" <tony.luck@intel.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: "Changelog-2.6.15": missing signoffs, descriptions
In-Reply-To: <43EA7680.6000207@tlinx.org>
Message-ID: <Pine.LNX.4.58.0602081457500.1564@shark.he.net>
References: <43E935BA.8050605@tlinx.org> <43E943FD.7090508@tlinx.org>
 <20060208193202.GA8275@agluck-lia64.sc.intel.com> <43EA7680.6000207@tlinx.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006, Linda Walsh wrote:

> Luck, Tony wrote:
> > On Tue, Feb 07, 2006 at 05:06:05PM -0800, Linda Walsh wrote:
> >
> >> Actually, ("talking" to myself?), parsing this file a bit more,
> >> I find many (~134) that are missing "Sign-offs".
> >>
> >> I take it that "Sign-off"s are also "optional" on commits
> >> and represent that the author specified under the "commit"
> >> tag did not need a "Sign-off"?
> >>
> > Most of them do
> > appear to be an author not signing off on his own work when working in
> > their own git tree.  Jeff Garzik seems to be an expert at this with 70
> > commits where he is listed as Author, but there is no signed-off-by line.
> > Linus is in second place with 8, but most of those were simply changing
> > the release in the Makefile for each "-rcN".  The 2 that weren't were
> > Linus fixing a silly typo and reverting a previous commit, perhaps these
> > were deliberately not signed?  Then there is a long tail...
> I suppose I'm unclear as to why sign-offs were added to the GIT
> change-log entries in the first place.
>
> I thought Sign-offs were added to provide an "accountability" trail for
> *ALL* new lines of code going into the kernel.  I though it was desired
> to know "Who" made or added "What" changes into the kernel to ensure
> that added code could be traced to its source to protect against
> infringement claims that might arise as well as verifying that changes
> had been reviewed for sanity and someone wasn't unintentionally or
> deliberately adding "suspect" or "insecure" code.
>
> Given human nature, I'm guessing there isn't sufficient concern about
> this issue until we've been bitten several times: hard.
>
> Sigh.

Linda, did you have some other point that you are trying to get to,
or is that it?  There are real efforts being made, although not
perfect.  That happens when people are involved.
Anyway, it feels like you are just getting to the surface/edge
of your complaint.

-- 
~Randy
