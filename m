Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263190AbUKZX1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbUKZX1H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbUKZTrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:47:22 -0500
Received: from zeus.kernel.org ([204.152.189.113]:65474 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262399AbUKZT1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:27:09 -0500
Date: Fri, 26 Nov 2004 00:50:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 47/51: GZIP support.
Message-ID: <20041125235030.GG2909@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101300182.5805.383.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101300182.5805.383.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The original compressor. Slow. I've tried to drop it, but for reasons I
> simply don't understand, some users still want it.

Okay, IGNORE THOSE @#*$&!)!& USERS!

You need to say no. 500 lines of code, when superior code is available
is bad idea. You know gzip is wrong thing. If some user wants it, it
is he maintaining the patch. Simple.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
