Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278170AbRJ3VMM>; Tue, 30 Oct 2001 16:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277823AbRJ3VMC>; Tue, 30 Oct 2001 16:12:02 -0500
Received: from hermes.toad.net ([162.33.130.251]:17118 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S278325AbRJ3VL6>;
	Tue, 30 Oct 2001 16:11:58 -0500
Subject: Re: What is standing in the way of opening the 2.5 tree?
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 30 Oct 2001 16:11:56 -0500
Message-Id: <1004476317.4367.24.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus has waited long enough to open up 2.5 that both he
and Alan are failing to resist the temptation to make
destabilizing changes in 2.4, with the result that
the day of branching is perpetually postponed.

What we have learned from the present experience is that
no kernel branch is really stable until it is entirely in
Alan Cox's hands.  Prior to that time, both Linus and Alan
are in "let's play with this" mode.  This has some benefits.
I think it's safe to say, though, that having two semi-stable
branches is inferior to having one stable branch that we
can rely on and one development branch that we can work on.

Perhaps a better approach in the future would be for Linus
to turn the kernel over to Alan as of 2.6.0 and to open 2.7.0
immediately.  That would be an incentive for Linus to refrain
from calling unstable kernels "stable" ones, and would allow
Alan to maintain 2.6 with the single aim of increasing
stability, according to one person's idea of what it takes
to do that.  Alan's "-ac" kernels would take the place of
Linus's "pre" kernels.  Linus would no longer produce "pre"
kernels because he's worse than Alan at maintaining a stable
kernel (as he admits) and anyway he would be busy with 2.7.

Having suggested, this, I'll remind everyone that Linus
and Alan can do whatever the hell the like.  Which is
what I like about Linux.

--
Thomas Hood

