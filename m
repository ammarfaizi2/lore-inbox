Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTJ1AGw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 19:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263780AbTJ1AGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 19:06:52 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:2308 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263777AbTJ1AGv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 19:06:51 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: APM suspend still broken in -test9
Date: 27 Oct 2003 23:56:41 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bnkbbp$m8c$1@gatekeeper.tmr.com>
References: <9cfbrs7d695.fsf@rogue.ncsl.nist.gov> <9cfekwy8y7h.fsf@rogue.ncsl.nist.gov>
X-Trace: gatekeeper.tmr.com 1067299001 22796 192.168.12.62 (27 Oct 2003 23:56:41 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <9cfekwy8y7h.fsf@rogue.ncsl.nist.gov>,
Ian Soboroff  <ian.soboroff@nist.gov> wrote:
| 
| I reported this also on -test8:
| http://marc.theaimsgroup.com/?l=linux-kernel&m=106694328730337&w=2
| 
| and it was confirmed by two other people in that thread.  I just
| tested it again with -test9.  Putting my laptop to sleep while X is
| running, then resuming, locks the machine hard.  Suspend works fine
| without X (plain old console mode).

What happens if you change to a text console and suspecnd? Does it
restart? And if so can you then change back to X?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
