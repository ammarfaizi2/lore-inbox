Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265778AbUEZShl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265778AbUEZShl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 14:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbUEZShk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 14:37:40 -0400
Received: from mail.kroah.org ([65.200.24.183]:16267 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265772AbUEZSfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 14:35:43 -0400
Date: Wed, 26 May 2004 11:31:13 -0700
From: Greg KH <greg@kroah.com>
To: Florian Hars <hars@bik-gmbh.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at usb:848
Message-ID: <20040526183113.GB25978@kroah.com>
References: <40B4AF96.5090608@bik-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B4AF96.5090608@bik-gmbh.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 04:54:14PM +0200, Florian Hars wrote:
> 
> Do you need anything else, besides the attached gunziped config.gz?

What kernel version is this?

Can you enable CONFIG_USB_STORAGE_DEBUG and send the resulting log to
the linux-usb-devel mailing list?

thanks,

greg k-h
