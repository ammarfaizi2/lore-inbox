Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbSLGQtO>; Sat, 7 Dec 2002 11:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbSLGQtO>; Sat, 7 Dec 2002 11:49:14 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:524 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262812AbSLGQtO>; Sat, 7 Dec 2002 11:49:14 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Date: 7 Dec 2002 16:55:26 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <ast95u$slg$1@gatekeeper.tmr.com>
References: <20021202223800.A24773@infradead.org> <1038868912.869.60.camel@phantasy>
X-Trace: gatekeeper.tmr.com 1039280126 29360 192.168.12.62 (7 Dec 2002 16:55:26 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1038868912.869.60.camel@phantasy>,
Robert Love  <rml@tech9.net> wrote:

| Ingo did explicitly mention he thought the O(1) scheduler was not 2.4
| material.  Whether this has changed, e.g. due to stabilization of the
| scheduler, I do not know.  But I do recall he had an opinion in the
| past.

  I have exchanged Email with him explaining why I feel it's highly
desirable on news servers, and I sent him some metrics with and without.
I had the impression he would reconsider the issue in the future. Note
that means "think about it again" rather than any implied change in his
conclusion.

  As long as patches are available I will continue to apply them, but I
certainly think the increased stability would suggest a backport to 2.4
at some time. I'm not totally sure that's now, Ingo is far better
qualified than I to evaluate the overall impact on more typical loads.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
