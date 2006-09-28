Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161334AbWI1WZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161334AbWI1WZS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 18:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161335AbWI1WZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 18:25:18 -0400
Received: from mail.suse.de ([195.135.220.2]:27861 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161334AbWI1WZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 18:25:16 -0400
Date: Thu, 28 Sep 2006 15:25:18 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Olaf Hering <olaf@aepfle.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [GIT PATCH] USB patches for 2.6.18
Message-ID: <20060928222518.GA12666@suse.de>
References: <Pine.LNX.4.44L0.0609281815170.10847-100000@iolanthe.rowland.org> <Pine.LNX.4.64.0609281521470.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609281521470.3952@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 03:22:04PM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 28 Sep 2006, Alan Stern wrote:
> > 
> > Another example of a bug for which the fix hasn't yet gone upstream to 
> > Linus.  The -mm kernel should work.  It you want to apply the fix 
> > yourself, it's these two patches:
> 
> Greg, can we please feed fixes to me faster?

Faster?  My god man, I just found out a few minutes ago that these were
causing problems for people.  I had only applied them to my local tree
about 12 hours ago :)

Give me a bit, I'll have them ready for you to pull from...

thanks,

greg k-h
