Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbWEYQM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWEYQM0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWEYQM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:12:26 -0400
Received: from cantor.suse.de ([195.135.220.2]:27358 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030241AbWEYQMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:12:25 -0400
Date: Thu, 25 May 2006 09:10:09 -0700
From: Greg KH <greg@kroah.com>
To: Milan Svoboda <msvoboda@ra.rockwell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] usb gadget: patches to support ixp4xx platform
Message-ID: <20060525161009.GA4379@kroah.com>
References: <44755B2A.7050205@ra.rockwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44755B2A.7050205@ra.rockwell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 09:22:18AM +0200, Milan Svoboda wrote:
> Hello,
> 
> following patches update pxa2xx_udc driver and ixp4xx arch depended files.
> This driver will be usable on ixp4xx platform without problems.
> 
> Current state is that the pxa2xx_udc.c can't be even compiled for
> the IXP4xx platform.
> 
> Feedback and comments are highly appreciated.

Please make these against the latest 2.6-rc kernel (Linus's tree) and
send them to the USB Gadget maintainer and CC: the linux-usb-devel
mailing list.

thanks,

greg k-h
