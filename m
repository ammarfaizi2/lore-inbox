Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbTIAFoU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 01:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263071AbTIAFoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 01:44:19 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:34441 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263052AbTIAFoO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 01:44:14 -0400
Date: Mon, 1 Sep 2003 06:44:13 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901054413.GF748@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk> <20030829154101.GB16319@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829154101.GB16319@work.bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> On Fri, Aug 29, 2003 at 06:35:10AM +0100, Jamie Lokier wrote:
> > I'd appreciate if folks would run the program below on various
> > machines, especially those whose caches aren't automatically coherent
> > at the hardware level.
> 
> Results for Alpha, IA64, MIPS, ARM, PARISC, PPC, MIPSEL, X86, SPARC

Thanks Larry.  That's a great range you have!
Collected and will be posted shortly in a table with the others.

> If you care, I also have freebsd (v2, v3, v4), netbsd 1.5, openbsd 3.0 (all
> bsd systems are x86, mostly celerons), hpux 10.20, sco, solaris, solaris/x86,
> Irix, MacOS X, AIX, Tru64 and probably some others.

AIX would be interesting; I don't have an RS6000.  The rest of the
CPUs I have results for, and it sounds like a lot of effort for what's
basically a compile/compatibility test.

However, if it's very little effort for you to run the test on them please do!

Thanks,
-- Jamie
