Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbULZVya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbULZVya (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 16:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbULZVya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 16:54:30 -0500
Received: from gprs214-34.eurotel.cz ([160.218.214.34]:32384 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261172AbULZVy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 16:54:28 -0500
Date: Sun, 26 Dec 2004 22:54:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Karel Kulhavy <clock@twibright.com>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       linux-kernel@vger.kernel.org
Subject: Re: How to hang 2.6.9 using serial port and FB console
Message-ID: <20041226215411.GA1810@elf.ucw.cz>
References: <20041226143118.GA5169@beton.cybernet.src> <20041226145334.GC1668@gallifrey> <20041226162426.GC5859@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041226162426.GC5859@beton.cybernet.src>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >   I wonder - is the board sending a 'break' signal to the PC? I just
> > remember years ago you could almsot lock machines up by constantly
> > sending break.
> 
> But in this case the kernel doesn't care if you run it on a console without
> a fancy background picture and hangs when you run it on a fancy background
> picture.
> 
> The picture is what seems to be evil here.

Picture is not in vanilla kernel => complain to gentoo.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
