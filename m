Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbUKZXXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUKZXXp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263198AbUKZTrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:47:43 -0500
Received: from zeus.kernel.org ([204.152.189.113]:65474 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262398AbUKZT1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:27:06 -0500
Date: Fri, 26 Nov 2004 00:43:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 42/51: Suspend.c
Message-ID: <20041125234358.GE2909@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101299659.5805.367.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101299659.5805.367.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here's the heart of the core :> (No, that's not a typo).
> 
> - Device suspend/resume calls
> - Power down
> - Highest level routine
> - all_settings proc entry handling

Can we get rid of all the debugging? It makes it hard to see real code
between all the debugging stuff.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
