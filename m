Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262677AbUJ0U3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbUJ0U3H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbUJ0U27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:28:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:17631 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262677AbUJ0U2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:28:12 -0400
Date: Wed, 27 Oct 2004 13:27:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "l_linux-kernel@mail2news.4t2.com" <ThomasWeber@abyss.4t2.com>
cc: Bill Davidsen <davidsen@tmr.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
In-Reply-To: <20041027200805.GA17759@4t2.com>
Message-ID: <Pine.LNX.4.58.0410271323040.28839@ppc970.osdl.org>
References: <4179F81A.4010601@yahoo.com.au> <417D7089.3070208@tmr.com>
 <Pine.LNX.4.58.0410251458080.427@ppc970.osdl.org> <20041027200805.GA17759@4t2.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Oct 2004, l_linux-kernel@mail2news.4t2.com wrote:
> > 
> > which is a hell of a lot more descriptive, in my opinion.
> 
> Indeed. But you hide this kind of information very carefully.
> Announcing with a subject like this one isn't very descriptive.

But that _wasn't_ in this idiotic thread.

The subject line of my announcement was

	Subject: Linux 2.6.9-rc4 - pls test (and no more patches)

and the body was

	Ok, 
	 trying to make ready for the real 2.6.9 in a week or so, so please give
	this a beating, and if you have pending patches, please hold on to them
	for a bit longer, until after the 2.6.9 release. It would be good to have
	a 2.6.9 that doesn't need a dot-release immediately ;)

	The appended shortlog gives a pretty good idea of what has been going on. 
	Mostly small stuff, with some architecture updates and an ACPI update 
	thrown in for good measure.

(plus the shortlog).

Not exactly "hidden", was it?

And to everybody complaining about "-rcX" - people don't want to break 
existing scripts, so the naming possibilities are either "-pre" or "-rc". 
And we've used "-rc" for the whole 2.6.x series, so there had better be a 
_good_ reason to change the naming.

So far, nobody has had a good reason. People are just complaining, because 
this is an area where you can complain without actually having any real 
hard technical input. It's "easy" to have an opinion.

So guys, look at the big picture. Is this really worth worrying over?

		Linus
