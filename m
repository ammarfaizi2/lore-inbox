Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUCPVpB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 16:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUCPVpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 16:45:00 -0500
Received: from mail.tmr.com ([216.238.38.203]:39184 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261718AbUCPVo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 16:44:27 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: lvm2 performance data with linux-2.6
Date: 16 Mar 2004 21:42:48 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <c37sco$fko$1@gatekeeper.tmr.com>
References: <200403081916.i28JGgE25794@mail.osdl.org> <4050E453.3010809@tmr.com> <20040311142515.A27177@osdlab.pdx.osdl.net>
X-Trace: gatekeeper.tmr.com 1079473368 16024 192.168.12.62 (16 Mar 2004 21:42:48 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040311142515.A27177@osdlab.pdx.osdl.net>,
Mark Wong  <markw@osdl.org> wrote:
| On Thu, Mar 11, 2004 at 05:12:35PM -0500, Bill Davidsen wrote:

| > Here's one thought: look at the i/o rates on individual drives using 
| > each stripe size. You *might* see that one size does far fewer seeks 
| > than others, which is a secondary thing to optimize after throughput IMHO.
| > 
| > If you don't have a tool for this I can send you the latest diorate 
| > which does stuff like this, io rate perdrive or per partition, something 
| > I occasionally find revealing.
| 
| Yeah, please do send me a copy.  I'd be interested to see what that might 
| turn up.  I've just been using iostat -x so far.

Okay, I posted the pointer a few days ago to LKML, did you get a chance
to try it? And if so, did it tell you anything?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
