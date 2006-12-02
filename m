Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163073AbWLBQin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163073AbWLBQin (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 11:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424130AbWLBQik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 11:38:40 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53777 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1163073AbWLBQiV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 11:38:21 -0500
Date: Sat, 2 Dec 2006 16:28:19 +0000
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.19
Message-ID: <20061202162818.GE4773@ucw.cz>
References: <20061201231626.GA7556@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201231626.GA7556@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here are a bunch of USB patches for 2.6.19.
> 
> They contain:
> 	- new driver for usb debug device (client side only so far)
> 	- helper functions to find usb endpoints easier
> 	- minor bugfixes
> 	- new device support
> 	- usb core rework for autosuspend logic
> 	- autosuspend logic that should now save a lot of power when no
> 	  one is using a USB device.

So we can now go to C3, extending battery life by about 2 hours on
x60? Good.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
