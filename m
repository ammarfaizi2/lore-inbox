Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbTKXXB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 18:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbTKXXAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 18:00:11 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60677 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261602AbTKXW7x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 17:59:53 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [RFC] generalise scheduling classes
Date: 24 Nov 2003 22:48:57 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bpu1sp$vil$1@gatekeeper.tmr.com>
References: <20031117021511.GA5682@averell> <1010800000.1069532100@[10.10.2.4]> <3FC01817.3090705@cyberone.com.au> <3FC0A0C2.90800@cyberone.com.au>
X-Trace: gatekeeper.tmr.com 1069714137 32341 192.168.12.62 (24 Nov 2003 22:48:57 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3FC0A0C2.90800@cyberone.com.au>,
Nick Piggin  <piggin@cyberone.com.au> wrote:

| We still don't have an HT aware scheduler, which is unfortunate because
| weird stuff like that looks like it will only become more common in future.

The idea is hardly new, in the late 60's GE (still a mainframe vendor at
that time) was looking at two execution units on a single memory path.
They decided it would have problems with memory bandwidth, what else is
new?


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
