Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbVKAUFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbVKAUFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVKAUFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:05:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65428 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751291AbVKAUFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:05:33 -0500
Date: Tue, 1 Nov 2005 21:05:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Make spitz compile again
Message-ID: <20051101200516.GA7172@elf.ucw.cz>
References: <20051031134255.GA8093@elf.ucw.cz> <1130773530.8353.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130773530.8353.39.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This is what I needed to do after update to latest linus
> > kernel. Perhaps it helps someone. 
> > 
> > Signed-off-by: Pavel Machek <pavel@suse.cz>
> > 
> > , but it is against Richard's tree merged into my tree, so do not
> > expect to apply it over mainline. Akita code movement is needed if I
> > want to compile kernel without akita support...
> 
> This is an update of my tree against 2.6.14-git3:
> 
> http://www.rpsys.net/openzaurus/temp/total-2.6.14-git3-r0.patch.gz

I did compile fixing, but it still will not boot. With neither my
config, not with yours. Just blank screen. Any ideas?

> http://www.rpsys.net/openzaurus/temp/total-2.6.14-git3-r0-defconfig-cxx00

								Pavel
-- 
Thanks, Sharp!
