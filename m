Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbTIHUOM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263554AbTIHUOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:14:12 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:13070 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263529AbTIHUOJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:14:09 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Scaling noise
Date: 8 Sep 2003 20:05:14 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bjindq$9g3$1@gatekeeper.tmr.com>
References: <200309030710.h837AXnR000500@81-2-122-30.bradfords.org.uk>
X-Trace: gatekeeper.tmr.com 1063051514 9731 192.168.12.62 (8 Sep 2003 20:05:14 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200309030710.h837AXnR000500@81-2-122-30.bradfords.org.uk>,
John Bradford  <john@grabjohn.com> wrote:

| Once the option of running a firewall, a hot spare firewall, a
| customer webserver, a hot spare customer webserver, mail server,
| backup mail server, and a few virtual machines for customers, all on a
| 1U box, why are you going to want to pay for seven or more Us in a
| datacentre, plus extra network hardware?

If you plan to run anything else on your firewall, and use the same
machine as a hot spare for itself, I don't want you as my ISP.
Reliability is expensive, and what you describe is known as a single
point of failure.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
