Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbVKWVDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVKWVDa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVKWVDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:03:30 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8869 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932412AbVKWVD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:03:29 -0500
Date: Wed, 23 Nov 2005 22:03:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] split sharpsl_pm.c into generic and corgi/spitz specific parts
Message-ID: <20051123210319.GA24197@elf.ucw.cz>
References: <20051123130350.GA23090@elf.ucw.cz> <1132754229.8016.55.camel@localhost.localdomain> <20051123194927.GA22375@elf.ucw.cz> <1132776965.8016.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132776965.8016.87.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > 1. We probably shouldn't (can't?) make changes like this in -rc
> > > kernels 
> > 
> > No, it does not really belong in -rc. I was hoping you would merge it
> > in your tree so I do not have big patch here and could keep only
> > collie changes...
> 
> Right, I misunderstood that. I'll happily maintain an in progress
> version of that split-up patch in the Zaurus tree.

Yes, that would be great for me.
								Pavel
-- 
Thanks, Sharp!
