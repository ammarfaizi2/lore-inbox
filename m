Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVAZNkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVAZNkl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 08:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVAZNkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 08:40:40 -0500
Received: from mail1.kontent.de ([81.88.34.36]:22490 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262293AbVAZNkh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 08:40:37 -0500
From: Oliver Neukum <oliver@neukum.org>
To: DervishD <lkml@dervishd.net>
Subject: Re: USB API, ioctl's and libusb
Date: Wed, 26 Jan 2005 14:40:38 +0100
User-Agent: KMail/1.7.1
Cc: Linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net
References: <20050126122014.GF58@DervishD>
In-Reply-To: <20050126122014.GF58@DervishD>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501261440.38766.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 26. Januar 2005 13:20 schrieb DervishD:
>     My question is: which interface should be used by user space
> applications, <linux/usb.h> or ioctl's? Is the ioctl interface
> deprecated in any way? In the "Programming guide for Linux USB Device
> Drivers", located in http://usb.in.tum.de/usbdoc/, I can't find ioctl
> interface references :?

You are supposed to use libusb.

	Regards
		Oliver

