Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbTKKP7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 10:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbTKKP7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 10:59:34 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:21766 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263531AbTKKP7d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 10:59:33 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.4 and cryptoloop
Date: 11 Nov 2003 15:48:58 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bor0da$bu3$1@gatekeeper.tmr.com>
References: <bop628$7km$1@gatekeeper.tmr.com> <20031111085530.GB11435@deneb.enyo.de>
X-Trace: gatekeeper.tmr.com 1068565738 12227 192.168.12.62 (11 Nov 2003 15:48:58 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031111085530.GB11435@deneb.enyo.de>,
Florian Weimer  <fw@deneb.enyo.de> wrote:
| bill davidsen wrote:
| 
| > I see that recent 2.4 has crypto. Is there a version of the tools which
| > will do cryptoloop using the kernel as released? I tried the old 2.4
| > version I had, and the latest version which works with 2.6, neither
| > worked to do an losetup.
| 
| losetup from util-linux 2.12 should work.

Hum, I tried that which I built on July 29, that might have been a pre
or something (I'm looking at the mod date on the directory). I'll check
and see what I find, thanks for input.

Actually, I think that version was built under 2.6.0-test4 (or so),
perhaps I have to rebuild under 2.4 and have separate 2.4 and 2.6
versions? Anyway, I'll look more since it should work.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
