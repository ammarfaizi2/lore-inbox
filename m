Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVFAX7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVFAX7h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVFAX53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:57:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:1997 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261520AbVFAXub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:50:31 -0400
Date: Wed, 1 Jun 2005 17:00:50 -0700
From: Greg KH <greg@kroah.com>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][1/3] RapidIO support: core
Message-ID: <20050602000050.GA5678@kroah.com>
References: <20050601110836.A16559@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601110836.A16559@cox.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 11:08:36AM -0700, Matt Porter wrote:
> Adds a RapidIO subsystem to the kernel. RIO is a switched
> fabric interconnect used in higher-end embedded applications.
> The curious can look at the specs over at http://www.rapidio.org
> 
> The core code implements enumeration/discovery, management of
> devices/resources, and interfaces for RIO drivers.
> 
> There's a lot more to do to take advantages of all the hardware
> features. However, this should provide a good base for folks
> with RIO hardware to start contributing.
> 
> Signed-off-by: Matt Porter <mporter@kernel.crashing.org>
> 
> Patch is 108KB and can be found here:
> ftp://source.mvista.com/pub/rio/l26_rio_core.patch

Care to split it up into logical sections and post it?  It should be
small enough to do so that way.

thanks,

greg k-h
