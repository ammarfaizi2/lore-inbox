Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUILVD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUILVD2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 17:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUILVD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 17:03:28 -0400
Received: from gprs40-135.eurotel.cz ([160.218.40.135]:24508 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261724AbUILVDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 17:03:19 -0400
Date: Sun, 12 Sep 2004 23:03:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Stefan Schweizer <sschweizer@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FYI: my current bigdiff
Message-ID: <20040912210306.GB3322@elf.ucw.cz>
References: <20040909134421.GA12204@elf.ucw.cz> <e796392204091201541320aa31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e796392204091201541320aa31@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I get an oops if I try to switch to console after resume. I suspended
> with LeaveXBeforeSuspend yes
> dmesg attached.

Your kernel has a lot more taints than I'd like... And I have no idea
what "LeaveXBeforeSuspend" is.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
