Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVCXWp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVCXWp7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 17:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVCXWp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 17:45:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:6591 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261183AbVCXWp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 17:45:56 -0500
Date: Thu, 24 Mar 2005 14:44:35 -0800
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/usb/core/devices.c: small corrections
Message-ID: <20050324224435.GA27681@kroah.com>
References: <20050322220816.GT1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322220816.GT1948@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 11:08:16PM +0100, Adrian Bunk wrote:
> total_written is used at places where it can't have any value different 
> from 0.
> 
> This patch is partially based on findings of the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

greg k-h
