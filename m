Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266158AbUAHVHH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 16:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266256AbUAHVHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 16:07:07 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18447 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S266158AbUAHVHF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 16:07:05 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] 2.6.0-rc1 - Watchdog patches
Date: 8 Jan 2004 20:54:59 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <btkg33$ego$1@gatekeeper.tmr.com>
References: <20040103002459.K30061@infomag.infomag.iguana.be> <20040103034541.GA5479@linux-sh.org>
X-Trace: gatekeeper.tmr.com 1073595299 14872 192.168.12.62 (8 Jan 2004 20:54:59 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040103034541.GA5479@linux-sh.org>,
Paul Mundt  <lethal@linux-sh.org> wrote:

| On Sat, Jan 03, 2004 at 12:24:59AM +0100, Wim Van Sebroeck wrote:
| >  drivers/char/watchdog/shwdt.c        |   14 +-
| >=20
| This change is useless, it's just whitespace modification. Perhaps you may =
| want
| to be more careful with diff in the future so you don't constantly generate
| superfluous changes. There definitely seems to be a lot of whitespace chang=
| es
| throughout the rest of these patches as well..

But the title of the patch was "cleanup whitespace," what did you
expect?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
