Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbULVVcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbULVVcn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 16:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbULVVcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 16:32:43 -0500
Received: from gprs214-153.eurotel.cz ([160.218.214.153]:24195 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262049AbULVVcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 16:32:36 -0500
Date: Wed, 22 Dec 2004 22:32:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: hugang@soulinfo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp bigdiff [was Re: [PATCH] Software Suspend split to two stage V2.]
Message-ID: <20041222213208.GA23761@elf.ucw.cz>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz> <1103585300.26640.47.camel@desktop.cunninghams> <20041222202831.GB7051@elf.ucw.cz> <1103750502.10045.27.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103750502.10045.27.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, we are starting with small steps... And since nobody knows how
> > to do one-device-suspend properly, we started with fixing system
> > suspend first.
> > 
> > Passing structure instead of u32 should make one-device-suspend easier
> > in future... Hopefully.
> 
> I could spend some time working on a proposal for this, if you like. It
> would probably do me good in preparation for my presentation on 2.6 PM
> (in general) at the CELF Linux Form next month.

You mean proposal for one-device-suspend? Well, I'd really like to
have whole machine case working, first... Then, yes, that would be
nice. It needs to be discussed at linux-pm list.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
