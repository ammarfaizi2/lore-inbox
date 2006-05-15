Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWEOJKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWEOJKF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 05:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWEOJKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 05:10:05 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:50933 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751173AbWEOJKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 05:10:04 -0400
Date: Mon, 15 May 2006 05:09:47 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: mingo@elte.hu, akpm@osdl.org, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document futex PI design
In-Reply-To: <Pine.LNX.4.58.0605150318110.6512@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605150508090.12114@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605090954150.7007@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605100331290.31598@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605100429220.436@gandalf.stny.rr.com> <20060510101729.GB31504@elte.hu>
 <Pine.LNX.4.58.0605100657510.2485@gandalf.stny.rr.com>
 <20060513201402.68c2b205.rdunlap@xenotime.net> <Pine.LNX.4.58.0605150318110.6512@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 May 2006, Steven Rostedt wrote:

> On Sat, 13 May 2006, Randy.Dunlap wrote:
>
> > > +
> > > +
> > > +1) Has owner that is pending
> > > +----------------------------
> > * insert blank line to be consistent
> >
>
> I didn't see this comment before.  I purposely didn't add a blank line
> here, because it's not a new section.  It's an index for the three cases
> that can happen.  I didn't want to add the two blank lines so that people
> notice that its an index, but I still used the '-' to make it stand out.
>
> Have another idea on how to make these three stand out without making them
> look like new sections?
>
> Should I put a two or three space indent for the three?
>

Oh, damn, I just notice that 1) didn't have a blank line at all and that
is what you were talking about. OK, will add, but I still like the
indentation better, so I'm glad I misunderstood you  ;)

-- Steve

