Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269783AbUJMSqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269783AbUJMSqU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 14:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269781AbUJMSqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 14:46:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:47047 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269783AbUJMSqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 14:46:16 -0400
Date: Wed, 13 Oct 2004 10:42:52 -0700
From: Greg KH <greg@kroah.com>
To: Alexander Wigen <alex@wigen.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Oleksiy <Oleksiy@kharkiv.com.ua>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: pl2303/usb-serial driver problem in 2.4.27-pre6
Message-ID: <20041013174251.GB17291@kroah.com>
References: <416A6CF8.5050106@kharkiv.com.ua> <20041011113609.GB417@logos.cnet> <20041012104848.530a5be7@lembas.zaitcev.lan> <200410131932.28896.alex@wigen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410131932.28896.alex@wigen.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 07:32:28PM +0000, Alexander Wigen wrote:
> 
> May I add that I have some problems with a pl2303 GPS device which causes 
> kernel panics when I pull it out of the USB port.
> 
> I don't know if it can be related, the device works fine until I unplug it.

On what kernel version do you have these problems?

thanks,

greg k-h
