Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVBRQ24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVBRQ24 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 11:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVBRQ24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 11:28:56 -0500
Received: from thunk.org ([69.25.196.29]:53183 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261393AbVBRQ2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 11:28:33 -0500
Date: Fri, 18 Feb 2005 11:27:29 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Sean <seanlkml@sympatico.ca>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Chris Friesen <cfriesen@nortel.com>, "d.c" <aradorlinux@yahoo.es>,
       cs@tequila.co.jp, galibert@pobox.com, kernel@crazytrain.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed
Message-ID: <20050218162729.GA5839@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Sean <seanlkml@sympatico.ca>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Chris Friesen <cfriesen@nortel.com>, "d.c" <aradorlinux@yahoo.es>,
	cs@tequila.co.jp, galibert@pobox.com, kernel@crazytrain.com,
	linux-kernel@vger.kernel.org
References: <seanlkml@sympatico.ca> <4912.10.10.10.24.1108675441.squirrel@linux1> <200502180142.j1I1gJXC007648@laptop11.inf.utfsm.cl> <1451.10.10.10.24.1108713140.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451.10.10.10.24.1108713140.squirrel@linux1>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 02:52:20AM -0500, Sean wrote:
> There are ways that the tools could coexist and work together better than
> they do today. If people would stop acting like BK was in jeopardy of
> being taken away from them and realize that others just want the ability
> to use their tools of choice too.

If you truly believe that BK would be able to add the value that it
does to the kernel development process by using some other SCM as the
master SCM, with BK being "underneath", as you proposed earlier, then
you do not understand why BK is fundamentally better than the current
open source SCM systems that are out there.

And people *can* use the tools of their choice today.  They can use
CVS, and diff+patch, and suffer with all of the limitations that those
tools have today.  And for people who are doing stuff around the
periphery, quilt is often really the best tool for them.  

> > Linus clearly considered not just his /own/ workflow, but the workflow
> > for the /whole/ kernel development community. In fact, BK was designed
> 
> Well, the /whole/ community isn't yet included, that's what we're talking
> about.

If it's about the whole ***kernel*** development community, then it's
pretty clear that the current system works quite well.  All of the
complaints have been coming primarily from SCM hackers, it seems, and
not people who truly need the power of more powerful than downloading
the bk snapshots, using the CVS export tree, and in the case where
they need to look at the changes in a single changeset bkbits.net.  

The "cost" of using BK seems to be primarily more theoretical, and
ideological, than real.  It's always seems to be about someone
kvetching that they want to use SVN and get finely grained changsets
through SVN, and they can't.  But how often does that happen, and
what's so painful of getting the finely grained changeset through
bkbits.net?  Not very.  So at the end of the day, it finally boils
down to being all about ideology, doesn't it?

Once again proving that Linus, as is often the case, was right all
along.

						- Ted
