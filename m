Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVDSS6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVDSS6p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 14:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVDSS6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 14:58:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:38374 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261591AbVDSS6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 14:58:42 -0400
Date: Tue, 19 Apr 2005 11:58:07 -0700
From: Greg KH <greg@kroah.com>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Git Mailing List <git@vger.kernel.org>,
       linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Message-ID: <20050419185807.GA1191@kroah.com>
References: <20050419043938.GA23724@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419043938.GA23724@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 09:39:38PM -0700, Greg KH wrote:
> Alright, let's try some small i2c and w1 patches...
> 
> Could you merge with:
> 	kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/

Nice, it looks like the merge of this tree, and my usb tree worked just
fine.

So, what does this now mean?  Is your kernel.org git tree now going to
be the "real" kernel tree that you will be working off of now?  Should
we crank up the nightly snapshots and emails to the -commits list?

Can I rely on the fact that these patches are now in your tree and I can
forget about them? :)

Just wondering how comfortable you feel with your git tree so far.

thanks,

greg k-h
