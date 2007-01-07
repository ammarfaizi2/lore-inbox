Return-Path: <linux-kernel-owner+w=401wt.eu-S964929AbXAGTO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbXAGTO4 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbXAGTO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:14:56 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:39210 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964929AbXAGTOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:14:55 -0500
Date: Sun, 7 Jan 2007 20:12:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       David Woodhouse <dwmw2@infradead.org>, Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
In-Reply-To: <20070107182151.7cc544f3@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0701072011510.4365@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
 <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr>
 <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc>
 <1168182838.14763.24.camel@shinybook.infradead.org>
 <20070107153833.GA21133@flint.arm.linux.org.uk> <20070107182151.7cc544f3@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 7 2007 18:21, Alan wrote:
>
>> So, in short, UTF-8 is all fine and dandy if your _entire_ universe
>> is UTF-8 enabled.  If you're operating in a mixed charset environment
>> it's one bloody big pain in the butt.
>
>Net ASCII is 7bit and is 1:1 mapped with UTF-8 unicode. It's just old
>broken 8bit encodings that are problematic.
>
>The kernel maintainers/help/config pretty consistently use UTF8

I've seen a lot of places that don't do so. Want a patch?


	-`J'
-- 
