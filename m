Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVBQXsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVBQXsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVBQXpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:45:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:31383 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261237AbVBQXU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:20:26 -0500
Date: Thu, 17 Feb 2005 15:17:43 -0800
From: Greg KH <greg@kroah.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci/quirks.c: unhide SMBus device on Samsung P35 laptop
Message-ID: <20050217231743.GB22195@kroah.com>
References: <4214062D.1040903@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4214062D.1040903@gmx.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 03:49:17AM +0100, Carl-Daniel Hailfinger wrote:
> Hi,
> 
> this patch is needed to make the SMBus device on my Samsung P35
> laptop visible. By default, it doesn't appear as a pci device.
> 
> Patch tested, works perfectly for me. Please apply.

Applied, thanks.

greg k-h
