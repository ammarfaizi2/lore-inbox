Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbSLCOHX>; Tue, 3 Dec 2002 09:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261446AbSLCOHX>; Tue, 3 Dec 2002 09:07:23 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:15365 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261427AbSLCOHW>; Tue, 3 Dec 2002 09:07:22 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: lkml, bugme.osdl.org?
Date: 3 Dec 2002 14:13:33 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <asie6d$5dr$1@gatekeeper.tmr.com>
References: <200212030724.gB37O4DL001318@turing-police.cc.vt.edu> <20021203121521.GB30431@suse.de>
X-Trace: gatekeeper.tmr.com 1038924813 5563 192.168.12.62 (3 Dec 2002 14:13:33 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021203121521.GB30431@suse.de>,
Dave Jones  <davej@codemonkey.org.uk> wrote:

| "xxx doesn't work in 2.5.47", then Rusty's module rewrite happened,
| and the tester didn't (or couldn't) see if it got fixed in subsequent
| kernels. I'll send out pings to such reports when they get to something
| like 5 kernels old. If the problem then doesn't get re-ACKed, I'll
| close it. Any objections?

  Since you are doing the work, you should set your own policy. I might
suggest that if we revert the module stuff to something working in
fewer than five versions you might ping then, and you might wait to
drop stuff of the "xxx fails in 2.5.47 as a module" until modules work
again or we officially go to a monolythic kernel.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
