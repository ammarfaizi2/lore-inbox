Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131562AbRCNWYb>; Wed, 14 Mar 2001 17:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131561AbRCNWYV>; Wed, 14 Mar 2001 17:24:21 -0500
Received: from quechua.inka.de ([212.227.14.2]:15150 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S131387AbRCNWYM>;
	Wed, 14 Mar 2001 17:24:12 -0500
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Alert on LAN for Linux?
In-Reply-To: <Pine.LNX.4.10.10103131842110.19423-100000@clueserver.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.36 (i686))
Message-Id: <E14dJg4-00003s-00@sites.inka.de>
Date: Wed, 14 Mar 2001 23:23:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.10.10103131842110.19423-100000@clueserver.org> you wrote:
> Alert on LAN makes the system up from power management type sleep when
> there are packets to be processed.  Why you would ever have sleep mode on
> a server is beyond me.

Most professional UPS with Network Management Cards can go a sever to sleep
mode if the power gets down and they will
awake the Server with a "Wake-on-Lan" signal if power is back.

Afaik Wake-On-Lan is a Mainboard/Bios Feature and will work with any OS which
can put the System into the right Sleep mode.

Greetings
Bernd
