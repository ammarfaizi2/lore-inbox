Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbULLUYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbULLUYM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 15:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbULLUX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 15:23:27 -0500
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:20100 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262116AbULLUUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 15:20:40 -0500
Date: Sun, 12 Dec 2004 21:20:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] swsusp: make some code static
Message-ID: <20041212202025.GF6272@elf.ucw.cz>
References: <20041212200004.GO22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041212200004.GO22324@stusta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The patch below makes some needlessly global code static.

Thanks, applied to my try, I'll eventually propagate into mainline.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
