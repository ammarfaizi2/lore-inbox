Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTJPS2r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 14:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbTJPS2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 14:28:47 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18693 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262914AbTJPS2q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 14:28:46 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test5 & test6 cd burning/scheduler/ide-scsi.c bug
Date: 16 Oct 2003 18:18:47 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bmmne7$hkf$1@gatekeeper.tmr.com>
References: <pan.2003.10.04.15.19.41.905451@smurf.noris.de> <Pine.LNX.4.44.0310051928440.25623-100000@llave.eproinet.com>
X-Trace: gatekeeper.tmr.com 1066328327 18063 192.168.12.62 (16 Oct 2003 18:18:47 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0310051928440.25623-100000@llave.eproinet.com>,
Mark W. Alexander <slash@dotnetslash.net> wrote:

| The first problem is that those applications need to be notified that
| "the times, they are a changin'." I suggest you submit bug reports to
| them so they can at least fail hard and be given time to prepare for
| the 2.6 way.

Would it not be better to fix the kernel rather than try to get the
authors of every application to add a Linux-only fix? And expect every
future application to be written for Linux and the rest of the world?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
