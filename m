Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUJNJIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUJNJIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 05:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUJNJIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 05:08:52 -0400
Received: from gprs212-66.eurotel.cz ([160.218.212.66]:10624 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266486AbUJNJIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 05:08:51 -0400
Date: Thu, 14 Oct 2004 11:08:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: William Wolf <wwolf@vt.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: fix x86-64 suspend in -rc3
Message-ID: <20041014090835.GB1039@elf.ucw.cz>
References: <41962C50.4020303@vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41962C50.4020303@vt.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hey, I have been trying to get swsusp working on my x86_64 laptop for a 
> while, and I finally found this email posted to the lkml by you, and 
> someone responded saying that it worked for them.  I assume it is for 
> 2.6.9-rc3, which is what i am currently running.  Im not sure if i tried 
> to apply this patch correctly though.  I do have some experience 
> patching with the -mm patches and the -rc patches and such.  What I did 
> to try to apply your patch was copy your patch straight into a textfile 
> (lets call it swsusp_patch), like this:

What about just going to -rc4?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
