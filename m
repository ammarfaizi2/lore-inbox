Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268213AbUIPUaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268213AbUIPUaI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 16:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268237AbUIPUaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 16:30:08 -0400
Received: from gprs214-49.eurotel.cz ([160.218.214.49]:1920 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268213AbUIPUaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 16:30:05 -0400
Date: Thu, 16 Sep 2004 21:26:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: vojtech@suse.cz
Subject: very strange issues on x86-64 with console switching
Message-ID: <20040916192622.GA3713@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I do not understand what went wrong, but (after swsusp?) I now can
only console switch once. After console switch "alt" key is forgotten
and I have to release it and press it again if I want to switch to
other console... Strange.
								Pavel 
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
