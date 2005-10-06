Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVJFLCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVJFLCY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 07:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVJFLCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 07:02:24 -0400
Received: from smtp17.wxs.nl ([195.121.6.13]:28846 "EHLO smtp17.wxs.nl")
	by vger.kernel.org with ESMTP id S1750819AbVJFLCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 07:02:23 -0400
Date: Thu, 06 Oct 2005 13:02:19 +0200 (CEST)
From: Freaky <freaky@bananateam.nl>
Subject: Re: MTP - Media Transfer Protocol support
In-reply-to: <200510061128.48506.oliver@neukum.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <1069.192.168.0.39.1128596539.squirrel@webmail.bananateam.nl>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Importance: Normal
X-Priority: 3 (Normal)
User-Agent: SquirrelMail/1.4.4
References: <4344DB73.9020604@bananateam.nl>
 <200510061128.48506.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can't check now, but what I mean is that syslog will only give one line,
that an USB device is inserted. Nothing more. I can find the device in
/sys/usb... so the system sees it, it just doesn't know what to do with
it.

Will checkup on libusb, I'm not a programmer though. Know a little C++
syntax, but no API's and this hardware stuff is way beyond me for now.

Can get you the USB device ID's and such if you would like those.

On Thu, October 6, 2005 11:28, Oliver Neukum said:
> Am Donnerstag, 6. Oktober 2005 10:08 schrieb Freaky:
>
>> Sorry if this is the wrong place to ask. But I figured it needs kernel
>> support first, because the USB device isn't recognized at all. MTP has a
>> general USB interface like mass storage from what I understand, so we'll
>> need drivers for that first I think.
>
> There is an USB list:
> linux-usb-devel@lists.sourceforge.net
>
> If you want to support this as a true filesystem with permissions,
> you will need a kernel driver. If not, you can access the device by
> libusb.
>
> What do you mean by "not recognised at all"? Does lsusb show it?
>
> 	Regards
> 		Oliver
>
>


-- 
Freaky
------------------------------------------------------
http://www.gnu.org/philosophy/no-word-attachments.html
http://www.gnu.org/philosophy/can-you-trust.html
------------------------------------------------------

