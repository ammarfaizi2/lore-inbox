Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbVHZNvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbVHZNvg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 09:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbVHZNvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 09:51:36 -0400
Received: from news.cistron.nl ([62.216.30.38]:32129 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S964835AbVHZNvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 09:51:35 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: Re: Linux-2.6.13-rc7
Date: Fri, 26 Aug 2005 13:51:34 +0000 (UTC)
Organization: Cistron
Message-ID: <den6p6$a34$1@news.cistron.nl>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org> <demrrd$si6$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1125064294 10340 62.216.30.70 (26 Aug 2005 13:51:34 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny ter Haar <dth@cistron.nl> wrote:
>Of course it will probably reboot just after sending this message.

Me and my big mouth...
If there is a god he is making fun of me right now ;-)

After 53 hours and 31 minutes it crashed.
dth      pts/1        zaphod.dth.net   Wed Aug 24 09:54 - crash (2+05:31)
reboot   system boot  2.6.13-rc7       Wed Aug 24 09:51         (2+05:41)

Prior to this kernel it had been running 2.6.12-mm1 without problems:
reboot   system boot  2.6.12-mm1       Sun Aug 14 12:13 (9+21:36)

I will now compile & run rc7-git1.

This machine has serial console but only for bootpurpose (no logging
possible) Wil try and setup some telnet capture service to try and 
fetch error.

Danny


