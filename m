Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284837AbRLRTnd>; Tue, 18 Dec 2001 14:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284696AbRLRTmQ>; Tue, 18 Dec 2001 14:42:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1041 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284795AbRLRTk3>; Tue, 18 Dec 2001 14:40:29 -0500
Subject: Re: The direction linux is taking
To: dana.lacoste@peregrine.com (Dana Lacoste)
Date: Tue, 18 Dec 2001 19:50:27 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'), linux-kernel@vger.kernel.org
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2A07@ottonexc1.ottawa.loran.com> from "Dana Lacoste" at Dec 18, 2001 07:18:51 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16GQFw-0008Uh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > is too noisy and many key people dont read it.
> 
> ...but if you are working with the code and you see something change
> the mailing list is the place to ask, correct?

Or its submitter - thyats why names in changelogs are so important

> > Many kernel bug reports end up invisible to some of the developers.
> 
> Many kernel developers don't read LKML.
> Isn't that their flaw?

Not really. If they read lk they would have no time to fix bugs.

> I sincerely challenge you to propose a method for centralizing
> bug tracking in the Linux kernel that _can_ be used by the
> community as a whole.  That means something that Linus would use
> _and_ somebody who doesn't subscribe to LKML can use to find out
> why he can't compile loop.o on his redhat 7.0 system with the
> kernel he got from kernel.org a few weeks ago.

You don't centralise it. You ensure the data is in common(ish) formats
and let the search tools improve. Would you build google by making all
the web run at one site ?
