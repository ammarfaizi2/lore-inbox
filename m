Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVCRBVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVCRBVU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 20:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVCRBTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 20:19:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:48591 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261421AbVCRBTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 20:19:15 -0500
Date: Thu, 17 Mar 2005 17:17:56 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove drivers/usb/image/hpusbscsi.c
Message-ID: <20050318011756.GD7994@kroah.com>
References: <20050303133856.GT4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303133856.GT4608@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 02:38:56PM +0100, Adrian Bunk wrote:
> USB_HPUSBSCSI was marked as BROKEN in 2.6.11 since libsane is the 
> preferred way to access these devices.
> 
> Unless someone plans to resurrect this driver, I'm therefore proposing 
> this patch to completely remove it.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

greg k-h

