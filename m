Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVJMWtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVJMWtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 18:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVJMWtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 18:49:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:27014 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932188AbVJMWtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 18:49:16 -0400
Date: Thu, 13 Oct 2005 15:48:39 -0700
From: Greg KH <greg@kroah.com>
To: Christian Krause <chkr@plauener.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in handling of highspeed usb HID devices
Message-ID: <20051013224839.GA3583@kroah.com>
References: <m34q7mwlvv.fsf@gondor.middle-earth.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m34q7mwlvv.fsf@gondor.middle-earth.priv>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 09:55:32PM +0200, Christian Krause wrote:
> 
> Here is a small patch which solves the whole problem:
> 
> --------------------------
> --- hid-core.c.old      2005-10-12 21:29:29.000000000 +0200
> +++ hid-core.c  2005-10-12 21:31:02.000000000 +0200

The patch is at the wrong level, and has spaces instead of tabs.

And no "signed-off-by" line :(

Take a look at Documentation/SubmittingPatches for how to create a patch
that I can apply and forward on.

Also, what device needs this patch?  Is it a device that I can buy
today?

thanks,

greg k-h
