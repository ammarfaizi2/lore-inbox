Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbULTXFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbULTXFG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbULTXEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 18:04:41 -0500
Received: from gprs215-245.eurotel.cz ([160.218.215.245]:27784 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261699AbULTXDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 18:03:00 -0500
Date: Tue, 21 Dec 2004 00:02:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org
Subject: Re: Problem with irqrouting and resume
Message-ID: <20041220230247.GB25027@elf.ucw.cz>
References: <1103474172.4219.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103474172.4219.26.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have a small problem with newer kernels on my laptop, an IBM X31.
> The problem is that the e1000 interface doesn't work after I've resumed
> from suspend to disk. This used to work fine until recently, not sure
> which kernel broke it. suspend-to-ram still works.

Try compiling e1000 into kernel (not module).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
