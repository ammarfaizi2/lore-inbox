Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424254AbWKKLZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424254AbWKKLZd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 06:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424347AbWKKLZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 06:25:33 -0500
Received: from [212.70.37.113] ([212.70.37.113]:7809 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1424254AbWKKLZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 06:25:32 -0500
From: Al Boldi <a1426z@gawab.com>
To: Valdis.Kletnieks@vt.edu
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Date: Sat, 11 Nov 2006 14:15:51 +0300
User-Agent: KMail/1.5
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Randy Dunlap <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
References: <200611090757.48744.a1426z@gawab.com> <200611110715.49343.a1426z@gawab.com> <200611110631.kAB6V12n011990@turing-police.cc.vt.edu>
In-Reply-To: <200611110631.kAB6V12n011990@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200611111415.51324.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Sat, 11 Nov 2006 07:15:49 +0300, Al Boldi said:
> > I don't think there is a lack of heuristics, nor is there a lack of
> > discussion.  What is needed, is a realization of the problem.
> >
> > IOW, respective tree-owners need to come to a realization of the state
> > of their trees, problem or not.  If it has a problem, that problem needs
> > to be fixed or backed out of stable and moved into dev.
>
> I keep trying to parse this, and it keeps coming up as "content-free".

Think denial.

> For starters, you don't even have a useful definition of "has a problem".
> There's a whole *range* of definitions for that, and even skilled and
> respected members of the Linux kernel community can disagree about whether
> something is "a problem".  For example, see the thread about a week ago
> about "Remove hotplug cpu crap from cpufreq".
>
> If, given a *specific* feature with high wart quotient, we can't agree on
> whether it needs to be fixed or backed out, we're doomed to fail if we
> start handwaving about problems "in general".  As a group, we suck at
> anything that isn't specific, like "Algorithm A is better than B for
> case XYZ".

We don't need to agree whether A is better than B, the mere fact that we 
acknowledge the problem is the first step in finding a solution.

So, either fix it, or back out.

OTOH, if there is no problem, then I guess we have blue skies...


Thanks!

--
Al

