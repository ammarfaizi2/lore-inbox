Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271363AbTGWWtp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 18:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271369AbTGWWtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 18:49:45 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:44808 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S271363AbTGWWtQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 18:49:16 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [2.6.0-test1] ACPI slowdown
Date: 23 Jul 2003 22:56:51 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bfn3rj$lql$1@gatekeeper.tmr.com>
References: <878yqpptez.fsf@deneb.enyo.de>
X-Trace: gatekeeper.tmr.com 1059001011 22357 192.168.12.62 (23 Jul 2003 22:56:51 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <878yqpptez.fsf@deneb.enyo.de>,
Florian Weimer  <fw@deneb.enyo.de> wrote:
| If I enable ACPI on my box (Athlon XP at 1.6 GHz, Epox EP-8KHa+
| mainboard), it becomes very slow (so slow that it's unusable).
| 
| Is this a known issue?  Maybe the thermal limits are misconfigured,
| and the CPU clock is throttled unnecessarily (if something like this
| is supported at all).

There have been reports before, check the archives. I seem to remember
that the solution involved changing some unobvious kernel feature, but
others have had similar problems.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
