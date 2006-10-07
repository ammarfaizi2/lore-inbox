Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWJGR7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWJGR7K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 13:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWJGR7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 13:59:10 -0400
Received: from ns2.suse.de ([195.135.220.15]:13008 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932468AbWJGR7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 13:59:09 -0400
Date: Sat, 7 Oct 2006 10:59:09 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.18
Message-ID: <20061007175909.GC17523@suse.de>
References: <20060927200626.GA10018@kroah.com> <200609290719.05445.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609290719.05445.dtor@insightbb.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 07:19:04AM -0400, Dmitry Torokhov wrote:
> On Wednesday 27 September 2006 16:06, Greg KH wrote:
> > drivers/usb/input/trancevibrator.c ? ? ?| ?159 +
> > ?
> 
> Greg,
> 
> There is  nothing in this driver that would relate to input subsystem,
> can it be moved into drivers/usb/misc?

Hm, good point, I'll move it in the next round of USB patches, thanks
for pointing it out.

greg k-h
