Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWGYSof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWGYSof (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWGYSof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:44:35 -0400
Received: from mail.suse.de ([195.135.220.2]:42909 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750858AbWGYSof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:44:35 -0400
Date: Tue, 25 Jul 2006 11:40:16 -0700
From: Greg KH <greg@kroah.com>
To: liyu <liyu@ccoss.com.cn>
Cc: Peter <peter@maubp.freeserve.co.uk>, thedoctor@tardis.homelinux.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USBHID: HID device simple driver interface
Message-ID: <20060725184016.GF9021@kroah.com>
References: <44B77AB0.8060700@maubp.freeserve.co.uk> <44C46F5B.8080506@ccoss.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C46F5B.8080506@ccoss.com.cn>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 02:57:31PM +0800, liyu wrote:
> ==================================
> HID device simple driver interface
> ==================================
> 
> ------------------------
> Version
> ------------------------
> 
>    This is the second version, this patch can apply on 2.6.17.6 kernel 
> tree.

Can you break these down into a series of patches, in the proper format
(as per Documentation/SubmittingPatches), so they could be applied to
the kernel tree?

Also, watch your line length, a number of them exceed 80 columns.

thanks,

greg k-h
