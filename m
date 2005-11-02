Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751526AbVKBWyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbVKBWyj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbVKBWyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:54:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60577 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751526AbVKBWyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:54:38 -0500
Date: Wed, 2 Nov 2005 23:53:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Carlos Martin <carlosmn@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sharp zaurus-5500: looking for testers
Message-ID: <20051102225337.GJ23943@elf.ucw.cz>
References: <20051102000003.GA467@elf.ucw.cz> <fe726f4e0511021440xdb80808p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe726f4e0511021440xdb80808p@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Is there someone out there, with sharp zaurus sl-5500, willing to test
> > kernels? There's a linux-z tree on kernel.org, which I try to more or
> > less keep in sync with mainline, that is slowly starting to get
> > usable. It could use some testing.
> 
> I cloned your tree but it said one of the packs wasn't in the index. I
> don't have the exact error message, sorry. I'll try again tomorrow.
> Also your git tree (repository?) in kernel.org is a bit broken. The
> git web interface gives me 403 error when I try to see a diff in your
> zaurus.git tree, and there's stuff that appears to be missing (history
> and commits).

Yes, I'm working on that. Slow line, so I try to pick pack files from
linus locally.

> > Main drawback is that battery charging is not yet done; touchscreen is
> > there but I did not have chance to test it with proper userspace
> > filtering.
> 
> Does this mean the battery won't get charged when using the 2.6
> kernel, or that it won't get reported?

Won't get charged. One trick is remove battery before booting 2.6 and
work from AC power.

								Pavel
-- 
Thanks, Sharp!
