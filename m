Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbVIIDbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbVIIDbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 23:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbVIIDbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 23:31:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:34176 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751404AbVIIDbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 23:31:11 -0400
Date: Thu, 8 Sep 2005 20:28:42 -0700
From: Greg KH <gregkh@suse.de>
To: Mark Lord <lkml@rtr.ca>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.13
Message-ID: <20050909032842.GA11369@suse.de>
References: <20050908235024.GA8159@kroah.com> <4320F661.2010706@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4320F661.2010706@rtr.ca>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 10:41:37PM -0400, Mark Lord wrote:
> Is someone actively working on USB Suspend/Resume support yet?
> 
> I ask because this is becoming more and more important as people
> shift more to portable notebook computers with Linux.
> 
> Enabling CONFIG_USB_SUSPEND is currently a surefire way to
> guarantee crashing my own notebook on suspend/resume,
> whereas it *usually* (but not always) survives when that
> config option is left unset.
> 
> Nothing complicated in the configuration -- just a USB mouse,
> but that's enough to nuke it.
> 
> Anyone looking at that stuff right now?

Yes, people are.  Please report this on the linux-usb-devel mailing
list, or file a bug at bugzilla.kernel.org

thanks,

greg k-h
