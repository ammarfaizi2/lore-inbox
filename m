Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263449AbVCMI2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbVCMI2k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 03:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbVCMI2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 03:28:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:27551 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263449AbVCMI1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 03:27:53 -0500
Date: Sun, 13 Mar 2005 00:27:36 -0800
From: Greg KH <greg@kroah.com>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] be more verbose in gen-devlist
Message-ID: <20050313082736.GA21182@kroah.com>
References: <20050311192858.GA11077@suse.de> <20050312203642.GC11865@kroah.com> <20050313081709.GA26100@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050313081709.GA26100@suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2005 at 09:17:09AM +0100, Olaf Hering wrote:
>  On Sat, Mar 12, Greg KH wrote:
> 
> > Why #if this?  Why not just always do this?
> 
> Because it always triggers with current sf.net snapshot.

Someone said they were going to submit those shorter strings that the
kernel has, back to sf.net.  Guess that didn't happen yet, and is the
main reason I can't just sync up all the time with that repository.

Oh well, we'll be dropping support for the pci.ids file by the end of
the year or so, so it's not that big of a deal.

thanks,

greg k-h
