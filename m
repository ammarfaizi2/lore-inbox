Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVJFJ25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVJFJ25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 05:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVJFJ25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 05:28:57 -0400
Received: from mail1.kontent.de ([81.88.34.36]:16602 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1750772AbVJFJ25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 05:28:57 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Freaky <freaky@bananateam.nl>, linux-usb-devel@lists.sourceforge.net
Subject: Re: MTP - Media Transfer Protocol support
Date: Thu, 6 Oct 2005 11:28:48 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <4344DB73.9020604@bananateam.nl>
In-Reply-To: <4344DB73.9020604@bananateam.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510061128.48506.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 6. Oktober 2005 10:08 schrieb Freaky:

> Sorry if this is the wrong place to ask. But I figured it needs kernel 
> support first, because the USB device isn't recognized at all. MTP has a 
> general USB interface like mass storage from what I understand, so we'll 
> need drivers for that first I think.

There is an USB list:
linux-usb-devel@lists.sourceforge.net

If you want to support this as a true filesystem with permissions,
you will need a kernel driver. If not, you can access the device by
libusb.

What do you mean by "not recognised at all"? Does lsusb show it?

	Regards
		Oliver
