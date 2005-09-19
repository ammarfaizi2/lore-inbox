Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVISHIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVISHIf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 03:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVISHIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 03:08:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32169 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932094AbVISHIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 03:08:34 -0400
Date: Mon, 19 Sep 2005 09:08:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Martin =?iso-8859-1?Q?v=2E_L=F6wis?= <martin@v.loewis.de>
Cc: Martin Mares <mj@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
Message-ID: <20050919070820.GA2382@elf.ucw.cz>
References: <4NsP0-3YF-17@gated-at.bofh.it> <4NsP1-3YF-19@gated-at.bofh.it> <4NsP1-3YF-21@gated-at.bofh.it> <4NsOZ-3YF-9@gated-at.bofh.it> <4NsYH-4bv-27@gated-at.bofh.it> <4NtBr-4WU-3@gated-at.bofh.it> <4NtL0-5lQ-13@gated-at.bofh.it> <432B2C49.8080008@v.loewis.de> <20050917120123.GA3095@ucw.cz> <432C0B51.704@v.loewis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432C0B51.704@v.loewis.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I just can't understand why (some) people are so opposed to this patch.
> It is a really trivial, straight-forward change. It introduces no
> policy, just a feature: you can put the UTF-8 signature in your script
> file, if you want to (and your scripting language supports it). By
> no means it forces you to put the UTF-8 signature in your all script
> files, let alone all your text files.

Why is binfmt_misc not enough for you?
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
