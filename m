Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266147AbUHVUwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbUHVUwA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 16:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUHVUwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 16:52:00 -0400
Received: from host4-67.pool80117.interbusiness.it ([80.117.67.4]:28053 "EHLO
	dedasys.com") by vger.kernel.org with ESMTP id S266147AbUHVUvW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 16:51:22 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux Incompatibility List
References: <87r7q0th2n.fsf@dedasys.com>
	<1093173291.24341.40.camel@localhost.localdomain>
From: davidw@dedasys.com (David N. Welton)
Date: 22 Aug 2004 22:48:58 +0200
Message-ID: <87vffaq4p1.fsf@dedasys.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sad, 2004-08-21 at 20:41, David N. Welton wrote:

> I think the "compatibility list" side is the more important. Trying
> to punish non helpful products/vendors isn't as productive as
> helping stuff that is Linux friendly.

A "compatibility list" is going to be pretty big, and hard to keep up
to date.  My thinking is that keeping track of a few notable things
that don't work is easier than running after all the stuff that does.

Of course, if automation can be brought to bear, that might make
either one much easier, but I'm dubious, because "it doesn't work" is
a vague concept, and really ought to be researched some.

A third concept "look, these guys support Linux really well!" (not
just "ok, it works") might also be easy to do.

By the way, the concept is not really about punishing vendors, and I
don't want it to come off looking like that.  It's about "this piece
of hardware does not work with Linux".  Who knows, maybe the fault is
with the kernel maintainers:-)  It might be nice if that gave some
incentive to the manufacturers to help bring the driver up to speed,
though.

> At what level is "Product" - do you need a category. How do you want
> to classify devices. I think this matters because you want
> eventually to be able to deal with things like tools that let users
> rate their setup functionality and submit it automatically.

I'd be worried about people who are just irritated that their system
didn't work out of the box hitting a button to submit this
information.

I suppose some sort of vote system could be put in place so that the 1
guy who didn't get the hardware to work gets outvoted by the 10 who
did, but there is more incentive to hit the button when you are
irritated than when everything 'just worked'.

> > How bad it is (1 to 10, 9 being it almost works and has only minor
> > bugs):

> > Reason (no specs, driver still being worked on, ...):

> > Url for more info:

> > An email address of yours that we may publish (so that we can contact
> > you if someone says "no, that works just fine!"):

> Wikipedia has a discussion page tagged to each article/entry. This
> works extremely well because it provides a public forum for
> discussion of what does/doesn't work, why and when.

It's a wiki, so for now I think placing comments on the bottom of the
page would be sensible.  We'll see if and how it grows.

> Could you add "Kernel.org bugzilla #" for not working ones, both to
> help people track them and to encourage submissions ?

Excellent idea.

Thanks for your thoughts,
-- 
David N. Welton
     Personal: http://www.dedasys.com/davidw/
Free Software: http://www.dedasys.com/freesoftware/
   Apache Tcl: http://tcl.apache.org/
       Photos: http://www.dedasys.com/photos/
