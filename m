Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbTKKPmD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 10:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTKKPmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 10:42:03 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18950 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263571AbTKKPmB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 10:42:01 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Date: 11 Nov 2003 15:31:26 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <boqvce$br1$1@gatekeeper.tmr.com>
References: <bop35i$795$1@gatekeeper.tmr.com> <Pine.LNX.4.53.0311110942280.8688@montezuma.fsmlabs.com>
X-Trace: gatekeeper.tmr.com 1068564686 12129 192.168.12.62 (11 Nov 2003 15:31:26 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.53.0311110942280.8688@montezuma.fsmlabs.com>,
Zwane Mwaikambo  <zwane@arm.linux.org.uk> wrote:
| On Mon, 10 Nov 2003, bill davidsen wrote:
| 
| > Looking at the system time being used I would say that this is doing
| > something odd. If that's using DMA then for some reason is it doing a
| > shitload of system calls at those times? I bet you're losing interrupts,
| > getting nasty mousing, and I would wonder about dropping incoming
| > network packets as well.

| That looks like fairly low system time and generally idle system to me, 
| and the interrupt rate isn't high at all.

Yes, I added a followup a few minutes later noting that I had a
line-wrap problem and misread the data. I haven't seen that post, but
that's what happened.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
