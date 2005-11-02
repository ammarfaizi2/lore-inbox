Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbVKBN1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVKBN1I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVKBN1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:27:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32916 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964982AbVKBN1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:27:07 -0500
Date: Wed, 2 Nov 2005 13:51:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Make spitz compile again
Message-ID: <20051102125107.GA12891@elf.ucw.cz>
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

Did you see any problems with touchscreen? I see "ts" registered,
interrupts coming, but opie does not see any clicks :-(.
							Pavel
-- 
Thanks, Sharp!
