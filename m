Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266194AbUGJIiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266194AbUGJIiV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 04:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUGJIiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 04:38:21 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:64919 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S266194AbUGJIiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 04:38:19 -0400
Subject: Re: [OT] Belkin Bluetooth Access Point GPL violation
From: Marcel Holtmann <marcel@holtmann.org>
To: Robert Lowery <rlowery@optusnet.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <000001c46615$b4608fb0$0302a8c0@vaio>
References: <000001c46615$b4608fb0$0302a8c0@vaio>
Content-Type: text/plain
Message-Id: <1089448693.13519.24.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 10 Jul 2004 10:38:13 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

> I recently purchase a Belkin Bluetooth Access Point with USB Print
> Server
> http://catalog.belkin.com/IWCatProductPage.process?Merchant_Id=&Section_
> Id=200583&pcount=&Product_Id=134669
> 
> By telnetting into it, I was able to find that it runs linux,
> specifically uClinux version 2.0.38.1pre7arm.
> 
> Investigating further, I found the device is made by
> www.rovingnetworks.com
> 
> The latest version of firmware may be obtained from
> http://www.belkin.com/firmware/bluetooth/f8t030/flash.bin or a beta
> version that includes PAN support at
> www.rovingnetworks.com/belkinpan4.bin
> 
> I contacted them at support@rovingnetworks.com  Mike Conrad replied to
> my request.
> 
> Initially, he said they wanted $5000 for a source code license.  When I
> Informed him of their GPL violation, he said
> "you could possibly have the linux os changes we made, but our bluetooth
> stack, for example, is not covered under the GPL. And we have special
> tools that enable web download, and  create the image that is loaded,
> etc."
> 
> Looking at the running system, it is not running any kernel modules, so
> I would expect the bluetooth stack to be compiled into the kernel
> proper, which in my understanding would mean they have to release the
> source.

may you tell me how you extracted the kernel and the filesystem from the
firmware files. I wanna take a look at it and find out what Bluetooth
stack they are using.

Regards

Marcel


