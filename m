Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318472AbSGaUHA>; Wed, 31 Jul 2002 16:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318473AbSGaUHA>; Wed, 31 Jul 2002 16:07:00 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:10766 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318472AbSGaUG7>; Wed, 31 Jul 2002 16:06:59 -0400
Date: Wed, 31 Jul 2002 16:03:59 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Federico Ferreres <fferreres@ojf.com>, linux-kernel@vger.kernel.org
Subject: Re: Funding GPL projects or funding the GPL?
In-Reply-To: <Pine.GSO.4.21.0207261642500.21586-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.3.96.1020731152735.10522A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2002, Alexander Viro wrote:

> What you and the rest of armchair generals do not get is that "adding
> features" is _not_ the hard part of work.  Doing that in a way that
> wouldn't be a permanent source of bugs afterwards and cleaning up the
> existing sources of bugs _IS_.  So is doing infrastructure work.  So
> is auditing code.  So is removing crap code.
> 
> None of that is covered by your "model".  99:1 that your "working driver
> for card" is going to contain a bunch of root holes.  _And_ be unmaintainable.

This is totally unrelated to the ecconomic model, we have many proofs that
code quality is unrelated to financial compensation. People write crap
code for both fun and profit. So what you say is totally true, but has
zero to do with why the author wrote the code. You have to QA any code
before using it, why the developer wrote it is irrelevant.

That said, let me suggest another possible model for funding free
software. It's in two parts. It would be helpful perhaps to discuss "is
this a good thing to do" first, before "how could you do that," and I do
know some similar things have been proposed and tried in the past. 

First the user driven part:

1.  User wants functionality X. Defines a functional spec. Also defines
the open source license to be used for the finished work. GPL, LGPL, BSD
or similar.

2. Concept approval. If the functionality is a library change, driver,
kernel hack, or similar, the entity in charge commits to accept the
functionality *if and only if* it meets some standard of fitness,
reliability, and maintainability. Otherwise some neutral party (user
group, FSF, individual) is selected as the acceptor.

3. Bidding. At that point the proposal goes up {somewhere} with a price (I
will pay $Y for functionality X). Developers may offer to do the work, and
most importantly other users may add to the offer. Not a fixed $20, but
whatever it's worth to them. After some time either an acceptable
developer is found or the offer expires.

4. Acceptance. Developer tests the software, publishes the result. The
acceptor tests the software and either accepts it or rejects it for a
objective reason related to not meeting the functional specs.

5. Deployment. Developer gets paid, software released under open source
license, if it's part of a package it's queued for the next release.

Developer driven part (only changes from user shown):

1. Definition. Developer states s/he wants to develop X, states functional
spec, license, and price of the work.

3. Bidding. If the stated desired price is not met after some time, other
developers may accept the current pledge (with user approval, of course).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

