Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVBPXXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVBPXXV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 18:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVBPXXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 18:23:21 -0500
Received: from gprs214-36.eurotel.cz ([160.218.214.36]:60823 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262121AbVBPXXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 18:23:11 -0500
Date: Thu, 17 Feb 2005 00:22:57 +0100
From: Pavel Machek <pavel@suse.cz>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Call for help: list of machines with working S3
Message-ID: <20050216232257.GC3865@elf.ucw.cz>
References: <20050216124336.GA27874@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050216124336.GA27874@mail.muni.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> does anyone have some experiences with intel i855 video card and S3?
> 
> For me the binary driver from Intel works with S3 but only X server is restored
> not the text console. 
> 
> With open source driver nothing is restored. I try to use s3_bios or s3_mode,
> nothing helps. Using  vbetool and post causes backlight turn on but display is
> full of garbage (vertical lines of different colors).

Can you do vga=normal and attempt to reload fonts?

									Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
