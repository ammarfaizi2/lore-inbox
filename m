Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263634AbTJ0XBe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 18:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263660AbTJ0XBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 18:01:34 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:23059 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263634AbTJ0XBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 18:01:33 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Linux 2.6.0-test9
Date: 27 Oct 2003 22:51:22 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bnk7ha$lqi$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org> <20031026120521.GD32168@vic20.blipp.com> <20031027182141.GH32168@vic20.blipp.com>
X-Trace: gatekeeper.tmr.com 1067295082 22354 192.168.12.62 (27 Oct 2003 22:51:22 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031027182141.GH32168@vic20.blipp.com>,
Patrik Wallstrom  <pawal@blipp.com> wrote:

| This patch worked for the Promise-controller:
| http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/2.6.0-test9-promise20378.patch

If this patch solves the problem, might I hope that it will be
considered critical enough a bugfix to get into the mainline? I assume
the SATA code added in test9 was intended to work, rather than as a
place holder.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
