Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVBQWnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVBQWnU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 17:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVBQWku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 17:40:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:62592 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261209AbVBQWjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 17:39:35 -0500
Date: Thu, 17 Feb 2005 14:25:50 -0800
From: Greg KH <greg@kroah.com>
To: Aur?lien Jarno <aurelien@aurel32.net>, sensors@Stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] I2C: New chip driver: sis5595 (resubmit)
Message-ID: <20050217222549.GF21188@kroah.com>
References: <20050206202641.GA31771@bode.aurel32.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206202641.GA31771@bode.aurel32.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 09:26:41PM +0100, Aur?lien Jarno wrote:
> Hi Greg,
> 
> Please find below the new version of the patch against kernel
> 2.6.11-rc3-mm1 to add the sis5595 driver (sensor part).
> 
> As you suggested, I have changed the PCI part of the driver, taking the
> via686a driver as an example. I have also changed the comparison of 
> jiffies by using time_after.

Applied, thanks.

greg k-h

