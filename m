Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbUDMPEi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 11:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbUDMPEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 11:04:38 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:31619 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263590AbUDMPEg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 11:04:36 -0400
Date: Tue, 13 Apr 2004 08:04:35 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: [BK] status
Message-ID: <20040413150435.GA12004@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The various BK machines we host are in at their new location and seem
to have stabilized (famous last words, every time I say something like
that something crashes).  kernel.bkbits.net, which is a shell account
machine for kernel developers, bk users or not, is not up yet, we've
had problems with that machine due to cooling and because we have a
much larger machine room we will be moving the guts of that machine to
a higher volume box to get better cooling.  ETA on that should be today.

We're moving towards remote control of the critical machines.  The machines
are already UPSed but they don't have serial consoles and/or remote power.
I've ordered a Sentry R2000 (model 203-0-1) which is supposed to be a pretty
nice remote power device.  We'll get serial consoles on the machines so 
that if they crash we can get the oops message and get some debugging help
(a couple of people, Bill Irwin in particular, went out of their way to
offer to help out with the the debugging.  I mention it only because it
was nice to that kind of friendly offer and I'm grateful).

We are currently on one T1 line, we moved one of the two to the new office
and one is at the old office so we had some overlap in case something
went horribly wrong.  It's clear that one T1 line isn't enough, you've
been keeping that T1 pretty full.  We'll be back up to two in a few
weeks.

Other than the up/down problems, have any of you noticed bkbits being 
slower since the move (which happened Friday or Saturday, it's sort of
a blur)?

Oregon State's open source lab has repeated their offer to take over hosting
bkbits.net and we may take them up on that if we can ever work out the 
logistics and you need the bandwidth.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
