Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTLCVDC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 16:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTLCVDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 16:03:02 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:9995 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261807AbTLCVDA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 16:03:00 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: XFS for 2.4
Date: 3 Dec 2003 20:51:49 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bqlid5$jji$1@gatekeeper.tmr.com>
References: <2D92FEBFD3BE1346A6C397223A8DD3FC0924C8@THOR.goeci.com> <20031202180251.GB17045@work.bitmover.com> <20031202181146.A27567@infradead.org> <20031202182037.GD17045@work.bitmover.com>
X-Trace: gatekeeper.tmr.com 1070484709 20082 192.168.12.62 (3 Dec 2003 20:51:49 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031202182037.GD17045@work.bitmover.com>,
Larry McVoy  <lm@bitmover.com> wrote:

| This is a process.  The process is supposed to screen out bad change.
| Maybe XFS got into 2.5/2.6 inspite of the process rather than because
| of it.  Maybe not.  Whatever the answer is, it's perfectly reasonable
| for the maintainer of the 2.4 tree to want someone he trusts to step
| forward and say "yeah, it's fine".  The fact that other VFS people
| aren't jumping up and down and saying this should go in is troublesome.
| If I were Marcelo the more the XFS people push without visible backing
| from someone with a clear vision of the VFS layer the more I'd push back.
| 
| Don't get me wrong, I have not looked at or used XFS in years.  I have
| no opinion about it at this point.  But I do have an opinion about process
| and what is going on here, in my opinion, violates the Linux development
| process.  Patches shouldn't go in just because you want them in, they go
| in because the maintainer chooses to bless them or someone he trusts chooses
| to bless them.

It has been my experience that a few hundred normal users actually
running code without problems is a LOT more reliable predictor of
stable operation than any one person reading the code and saying it
looks good. Users check out the exception handling paths better ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
