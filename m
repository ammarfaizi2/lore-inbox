Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269277AbUJQTOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269277AbUJQTOT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 15:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268447AbUJQTNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 15:13:41 -0400
Received: from gprs214-97.eurotel.cz ([160.218.214.97]:2176 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269272AbUJQTKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 15:10:50 -0400
Date: Sun, 17 Oct 2004 21:10:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
Message-ID: <20041017191031.GA7476@elf.ucw.cz>
References: <2HO0C-4xh-29@gated-at.bofh.it> <2I5b2-88s-15@gated-at.bofh.it> <2I5E5-6h-19@gated-at.bofh.it> <2I7Zd-1TK-11@gated-at.bofh.it> <E1CB10O-0000HL-FJ@localhost> <20040925101640.GB4039@elf.ucw.cz> <m2zn2uigka.fsf@tnuctip.rychter.com> <20041011133234.GA16217@atrey.karlin.mff.cuni.cz> <m2hdp1gvbq.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2hdp1gvbq.fsf@tnuctip.rychter.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Sure, flame me if you think this is the right thing to do. But I will
> continue to pitch in with a users' opinion sometimes, because I really
> believe it is important.
> 
> It is easy to lose sight of the user perspective on these things if all
> you deal with is kernel development. You probably reboot your machine
> dozens of times a day anyway. However, for some users crashes and
> reboots are *very* expensive. These people (myself included) consider
> sprinkling the code with panics, crashing and failing an unacceptable
> thing to do.

You can have code that does not panic, does not crash, does not
corrupt your data, never fails to suspend and is in Linus' tree.

...no, that is too good. It sounds like a fairy tale.

So pick any four.
								Pavel

PS: And it is real. We have conflicting goals here and I consider
"refuses to suspend" least critical.
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
