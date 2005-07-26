Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVGZIIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVGZIIF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 04:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVGZIIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 04:08:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49046 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261850AbVGZIID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 04:08:03 -0400
Date: Tue, 26 Jul 2005 10:07:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mark Underwood <basicmark@yahoo.com>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk
Subject: Re: [patch] ucb1x00: touchscreen cleanups
Message-ID: <20050726080756.GB11995@elf.ucw.cz>
References: <20050726074627.GA11975@elf.ucw.cz> <20050726080412.5504.qmail@web30313.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726080412.5504.qmail@web30313.mail.mud.yahoo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I am in the process of porting Linux 2.6.11.5 to the
> Helio PDA (MIPS R3912 based) and if I remember
> correctly it is using a UCB1x00 (or Toshiba clone).
> Please could you make sure your patches will work
> across arch. Now I have my kernel up and running (well
> mainly falling :-() my next task is to get write the
> frame buffer driver and then look at the UCB1x00 as I
> need it for sound and touch screen. So in a day or two
> I will start to try to integrate your work into my
> kernel.

Well, without MIPS PDA to test on.... No, I do not think I broke
anything... but you'll have to ensure testing yourself.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
