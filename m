Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267475AbTGTQ7n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 12:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267533AbTGTQ7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 12:59:43 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:12419 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S267475AbTGTQ7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 12:59:42 -0400
Date: Sun, 20 Jul 2003 18:24:13 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307201724.h6KHODWk002989@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, vonbrand@inf.utfsm.cl
Subject: Re: [OT] HURD vs Linux/HURD
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >                                                              We are
> > discussing what parts of the Hurd and GNU Mach contain code derived
> > from Linux.  That's actually quite interesting, and on-topic.
>
> Why? Are you planing to take anything from Hurd? Or complain that they
> (legally!) are taking GPLed code and use it elsewhere? In the fist case,
> discussion about the _technical_ merit of the code to swipe is on-topic,
> all else isn't. The second case is none of your business, (unless you wrote
> the code and did not GPL it).

I'm certaily _not_ going to complain that code has been taken from
Linux - as you pointed out, that is perfectly legal.

The use of the Linux drivers in the Hurd is the closest thing[1] we've
got to a fork[2] of the Linux kernel.

So, yes, I am interested in seeing if they have done anything better
than we have, or have investigated possibilities we haven't.

John.

[1] I am _NOT_ saying that the Hurd is a fork of Linux, but that it's
about the only codebase which took Linux kernel code, and has let it
evolve separately from mainline over a number of years.  OK, the Vax
port has lived outside of mainline for a number of years too, but
that's mainly architecture specific changes.

[2] OK, ELKS is a fork of the Linux kernel, but not specifically
targeted at 386+ boxes.

John.
