Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268250AbUIPUci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268250AbUIPUci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 16:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268237AbUIPUaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 16:30:11 -0400
Received: from gprs214-49.eurotel.cz ([160.218.214.49]:2176 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268236AbUIPUaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 16:30:06 -0400
Date: Thu, 16 Sep 2004 21:30:14 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: vojtech@suse.cz
Subject: Re: very strange issues on x86-64 with console switching
Message-ID: <20040916193014.GA997@elf.ucw.cz>
References: <20040916192622.GA3713@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916192622.GA3713@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I do not understand what went wrong, but (after swsusp?) I now can
> only console switch once. After console switch "alt" key is forgotten
> and I have to release it and press it again if I want to switch to
> other console... Strange.

Okay, it happens on fresh boot, too. Only remotely strange thing I'm
doing here is load of keymap that swaps ctrl and capslock. Linux
2.6.9-rc1-mm5. Problem is there only in 64-bit mode.

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
