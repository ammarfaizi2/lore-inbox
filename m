Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUCDSwh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbUCDSuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:50:19 -0500
Received: from mail.kroah.org ([65.200.24.183]:3228 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262073AbUCDSuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:50:09 -0500
Date: Thu, 4 Mar 2004 10:46:02 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040304184602.GI13907@kroah.com>
References: <20040303000957.GA11755@kroah.com> <1078422507.3614.20.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078422507.3614.20.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 07:48:27PM +0200, Martin Schlemmer wrote:
> On Wed, 2004-03-03 at 02:09, Greg KH wrote:
> > I've released the 021 version of udev.  It can be found at:
> >  	kernel.org/pub/linux/utils/kernel/hotplug/udev-021.tar.gz
> > 
> 
> Is the issue that causes missing events with udevsend (and udev in
> some cases - like alsa and it seems the -mm tree) with slower machines
> known yet?

No, this is not really known.  I've heard rumors of it, but been unable
to duplicate it here.   Some solid error reports would be greatly
appreciated...

thanks,

greg k-h
