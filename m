Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbUJYNng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbUJYNng (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbUJYNll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:41:41 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:32650 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261808AbUJYNje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:39:34 -0400
Date: Mon, 25 Oct 2004 15:39:51 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Joe Perches <joe@perches.com>
Cc: Larry McVoy <lm@work.bitmover.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041025133951.GW14325@dualathlon.random>
References: <20041019213803.GA6994@havoc.gtf.org> <4d8e3fd3041019145469f03527@mail.gmail.com> <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org> <20041023161253.GA17537@work.bitmover.com> <4d8e3fd304102403241e5a69a5@mail.gmail.com> <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com> <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random> <1098707342.7355.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098707342.7355.44.camel@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 05:29:02AM -0700, Joe Perches wrote:
> 1. BK has improved LK workflow
[..]
> If your answer does not include 1, why?

as a matter of fact nobody can know how the workflow would be if _all_
kernel developers would have been able to take advantage of a
distributed revision control system in the last ~3 years. The simple
fact I try to avoid discussing this topic on public lists to avoid be
targeted as whiner as usual, doesn't mean Larry can speak for myself
saying the few people like me now changed their mind and they agrees BK
generally helps the workflow.

> From my view, LK workflow post patch penguin (ie: BK)
> is improved simply because fewer patches seem to be lost.

IMHO that's largerly thanks to Andrew, and he's not using BK but quilt
to manage -mm, and as far as I can see his merges with Linus are using
patches. Infact I'm only sending my seldom patches to Andrew.
