Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTLLQ24 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 11:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbTLLQ24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 11:28:56 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47121 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261193AbTLLQ2x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 11:28:53 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [ANNOUNCE] -tiny tree for small systems (2.6.0-test11)
Date: 12 Dec 2003 16:17:30 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <brcpmq$a2n$1@gatekeeper.tmr.com>
References: <20031212033734.GG23787@waste.org> <20031212154443.GN23731@stop.crashing.org> <20031212155948.GK23787@waste.org> <20031212160508.GO23731@stop.crashing.org>
X-Trace: gatekeeper.tmr.com 1071245850 10327 192.168.12.62 (12 Dec 2003 16:17:30 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031212160508.GO23731@stop.crashing.org>,
Tom Rini  <trini@kernel.crashing.org> wrote:

| Well part of the problem that came up when this was brought up during
| 2.5 is that adding a whole bunch of CONFIG options for things Just Won't
| Happen (too complex, PITA, etc).  OTOH however, lots of stuff like that
| keeps getting in.

But now we have a config section for disabling things which may not be
needed in embedded systems. So there's a fair chance that tweaks and
such can be accepted as long as they're in the area where most will
never go.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
