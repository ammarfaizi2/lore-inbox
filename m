Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbULQAcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbULQAcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 19:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbULQAcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 19:32:11 -0500
Received: from gprs215-223.eurotel.cz ([160.218.215.223]:46982 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262203AbULQAcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 19:32:08 -0500
Date: Fri, 17 Dec 2004 01:31:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-pm@lists.osdl.org, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Cleanup PCI power states
Message-ID: <20041217003152.GE25573@elf.ucw.cz>
References: <20041116130445.GA10085@elf.ucw.cz> <20041116155613.GA1309@kroah.com> <20041117120857.GA6952@openzaurus.ucw.cz> <20041124234057.GF4649@kroah.com> <20041125113631.GB1027@elf.ucw.cz> <20041217000526.GA11531@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217000526.GA11531@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Okay, here it is, slightly expanded version. It actually makes use of
> > newly defined type for type-checking purposes; still no code changes.
> 
> Hm, ok, can everyone agree (especially the linux-pm list people) that
> the patch below is the way we are all moving toward?
> 
> Because, if so, I'll apply this and then start working on fixing all of
> the sparse warnings this will cause.

I do have some warning-fixes here, too. So if you apply it tell me and
I'll generate a copy for you.

									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
