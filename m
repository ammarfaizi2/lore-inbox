Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266525AbUGUPtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266525AbUGUPtc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 11:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266526AbUGUPtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 11:49:31 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:30546 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266525AbUGUPtW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 11:49:22 -0400
Subject: Re: [PATCH] delete devfs
From: Kasper Sandberg <lkml@metanurb.dk>
To: Greg KH <greg@kroah.com>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040721141524.GA12564@kroah.com>
References: <20040721141524.GA12564@kroah.com>
Content-Type: text/plain
Date: Wed, 21 Jul 2004 17:49:21 +0200
Message-Id: <1090424961.16171.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pretty nice - i like it

On Wed, 2004-07-21 at 10:15 -0400, Greg KH wrote:
> Hm, seems kernel.org dropped my big patch, so the patch below can be
> found at:
> 	www.kernel.org/pub/linux/kernel/people/gregkh/misc/2.6/devfs-delete-2.6.8-rc2.patch
> 
> 
> 
> ----- Forwarded message from Greg KH <greg@kroah.com> -----
> 
> Date: Wed, 21 Jul 2004 02:49:37 -0400
> From: Greg KH <greg@kroah.com>
> To: Andrew Morton <akpm@osdl.org>
> Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
> Subject: [PATCH] delete devfs
> 
> Ok, to test out the new development model, here's a nice patch that
> simply removes the devfs code.  No commercial distro supports this for
> 2.6, and both Gentoo and Debian have full udev support for 2.6, so it is
> not needed there either.  Combine this with the fact that Richard has
> sent me a number of good udev patches to fix up some "emulate devfs with
> udev" minor issues, I think we can successfully do this now.
> 
> Andrew, please apply this to your tree and feel free to send it to Linus
> when you think it should be there.
> 
> thanks,
> 
> greg k-h
> 
> <PATCH SNIPPED>
> 
> ----- End forwarded message -----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

