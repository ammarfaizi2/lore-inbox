Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbTJ1NXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 08:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbTJ1NXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 08:23:47 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:20485 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263969AbTJ1NXq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 08:23:46 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: status of ipchains in 2.6?
Date: 28 Oct 2003 13:13:34 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bnlq1u$pnn$1@gatekeeper.tmr.com>
References: <200310280127.h9S1RM5d002140@napali.hpl.hp.com> <bnl92k$iae$2@sea.gmane.org>
X-Trace: gatekeeper.tmr.com 1067346814 26359 192.168.12.62 (28 Oct 2003 13:13:34 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <bnl92k$iae$2@sea.gmane.org>,
Holger Schurig  <h.schurig@mn-logistik.de> wrote:
| > Unlike ipchains, iptables works perfectly fine, so perhaps we just
| > need to update Kconfig to discourage ipchains on ia64 (and/or other
| > 64-bit platforms)?
| 
| Perhaps we simply drop ipchains support for good?

Since it worked in early test versions, how 'bout we just unbreak it?
Since the support has been in the kernel, and did work until it was
recently broken, perhaps we could skip the "I don't need it" phase and
fix the problem.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
