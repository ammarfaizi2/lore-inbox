Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbUEEVJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUEEVJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 17:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264810AbUEEVJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 17:09:28 -0400
Received: from mail.kroah.org ([65.200.24.183]:22676 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262050AbUEEVJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 17:09:27 -0400
Date: Wed, 5 May 2004 13:36:04 -0700
From: Greg KH <greg@kroah.com>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: linux-usb-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add support for eGalax Touchscreen USB
Message-ID: <20040505203603.GE28427@kroah.com>
References: <200405032124.46062.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405032124.46062.daniel.ritz@gmx.ch>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 09:24:46PM +0200, Daniel Ritz wrote:
> hi
> 
> this is the second version of the patch to add support for eGalax Touchkit USB
> touchscreen. changes since last patch:
> - fixed the bug in open, found by oliver neukum
> - renamed driver from touchkit.c to touchkitusb.c (since the thing also exists
>   as RS232, PS/2 and I2C)
> - some minor coding style updates
> 
> against 2.6.6-rc3-bk. 
> greg, feel free to apply it :)

Looks good, thanks for fixing it.

Applied.

greg k-h

