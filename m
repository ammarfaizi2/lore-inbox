Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265905AbUFDSPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265905AbUFDSPB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265898AbUFDSPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:15:01 -0400
Received: from mail.kroah.org ([65.200.24.183]:55989 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265905AbUFDSNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:13:49 -0400
Date: Fri, 4 Jun 2004 11:12:52 -0700
From: Greg KH <greg@kroah.com>
To: nardelli <jnardelli@infosciences.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Memory leak in visor.c and ftdi_sio.c
Message-ID: <20040604181252.GA11499@kroah.com>
References: <40C08E6D.8080606@infosciences.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C08E6D.8080606@infosciences.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 10:59:57AM -0400, nardelli wrote:
> Note that I have not verified any of the below on
> hardware associated with drivers/usb/serial/ftdi_sio.c,
> only with drivers/usb/serial/visor.c.  If anyone has
> hardware for this device, I would appreciate your comments.
> 
> A memory leak occurs in both drivers/usb/serial/ftdi_sio.c
> and drivers/usb/serial/visor.c when the usb device is
> unplugged while data is being written to the device.  This
> patch should clear that up.
> 
> This was prepared against 2.6.7-rc2.

This patch has all of the tabs stripped out of it and can not be applied
:(

Care to try it again?

thanks,

greg k-h
