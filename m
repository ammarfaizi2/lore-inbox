Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290587AbSCGCZn>; Wed, 6 Mar 2002 21:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290767AbSCGCZY>; Wed, 6 Mar 2002 21:25:24 -0500
Received: from 1Cust22.tnt15.sfo3.da.uu.net ([67.218.75.22]:18694 "EHLO
	morrowfield.home") by vger.kernel.org with ESMTP id <S290713AbSCGCZS>;
	Wed, 6 Mar 2002 21:25:18 -0500
Date: Thu, 7 Mar 2002 06:25:12 -0800 (PST)
Message-Id: <200203071425.GAA06679@morrowfield.home>
From: Tom Lord <lord@regexps.com>
To: linux-kernel@vger.kernel.org
cc: davej@suse.de
Subject: Why not an arch mirror for the kernel?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



While I won't take a position on the petition, the post quoted below
has some practical implications, and some others have been raised that
I'll answer:

	Dave Jones observes:

	Something I've not yet worked out is why none of the
	proponents of arch, subversion etc are offering to run a
	mirror of Linus' bitkeeper tree for those who don't want to
	use bk, but "must have 0-day kernels".

In my case (I'm the author arch) it's entirely a resource problem.
I simply can't afford it at the moment.  Otherwise, it would likely be
a high priority.

Let me share some news for people who might be interested in
alternatives to BK:

At least one kernel contributor has a private arch repository for
kernel work, so it seems to be at least marginally doable.  I am
certain that further testing, performance improvements, better
documentation, and some touch-ups to existing functionality are
necessary before I would say "arch is so good that you have no excuse
for not using it for kernel work."  Nevertheless, it's interesting
that someone is already experimenting with it and the kernel.

I am working on some tools that will help to implement automatic,
incremental, bidirectional gateways between arch, Subversion, and Bk.

I've written a document that describes the state of arch and the
options that I think exist for getting from its current state to a
state where it is unambiguously the best choice.  See:

	http://www.regexps.com/survey.html

I would like to hear (off-list) from people who are interested in
eventually using arch for kernel work, but who aren't yet "early
adopters".  What milestones or features are needed, in your opinion?
Please be sure to mention in your email if I may quote you or not (the
default presumption will be that I may not, though I may anonymously
paraphrase interesting messages and report aggregate results.)

Thanks,
-t
