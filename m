Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVLLW5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVLLW5q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 17:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVLLW5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 17:57:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35773 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932225AbVLLW5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 17:57:45 -0500
Date: Mon, 12 Dec 2005 14:58:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.15-rc5-mm1
Message-Id: <20051212145845.7a76da76.akpm@osdl.org>
In-Reply-To: <20051211223638.27a0749e@werewolf.auna.net>
References: <20051204232153.258cd554.akpm@osdl.org>
	<20051206000524.74cb2ddc@werewolf.auna.net>
	<20051210233655.GH11094@kroah.com>
	<20051211004611.60248a2f@werewolf.auna.net>
	<20051211223638.27a0749e@werewolf.auna.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> > Sorry for the delay. I'm just compiling all rcs from rc2 to rc5 and will
> > try to boot whith them.
> > 
> > For the rest of your questions:
> > - I have no /etc/udev/agents.d/usb/usbcore
> > - I have killed all the devfs compat scripts/rules (BTW, when will be finally
> >   erradicated from  udev ;) ?
> > - Distro: Mandriva Cooker, updated daily, udev-077 now (the hangs I reported
> >   were with 075).
> > 
> > More info soon...
> > 
> 
> No problems with plain rc5. It does not seem to _always_ happen on -mm1,
> I thing I even got a clean boot, but just one. 
> Detailed oops screenshot is here:
> 
> http://belly.cps.unizar.es/~magallon/oops/oops.jpg
> 

Thanks for that.

Let's add the usb list..
