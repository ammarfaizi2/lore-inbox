Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269571AbTGJURX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 16:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269561AbTGJUQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 16:16:32 -0400
Received: from [212.209.10.216] ([212.209.10.216]:31147 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S269533AbTGJUPp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 16:15:45 -0400
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB03277AA7@mailse01.axis.se>
From: Mikael Starvik <mikael.starvik@axis.com>
To: "'Greg KH'" <greg@kroah.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'starvik@axis.com'" <mikael.starvik@axis.com>
Subject: RE: [PATCH] CRIS architecture update for 2.5.74
Date: Thu, 10 Jul 2003 22:30:20 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, there will be a future for this driver and the other missing
drivers. I have choosed to delete drivers that we haven't ported yet
because otherwise people assume that they work. I will try to
port the USB host driver and the other missing drivers from 2.4 as 
soon as possible.

/Mikael

-----Original Message-----
From: Greg KH [mailto:greg@kroah.com]
Sent: Thursday, July 10, 2003 9:54 PM
To: Linux Kernel Mailing List; starvik@axis.com
Subject: Re: [PATCH] CRIS architecture update for 2.5.74


On Thu, Jul 10, 2003 at 05:30:06PM +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.1358.18.1, 2003/07/10 10:30:06-07:00, mikael.starvik@axis.com
> 
> 	[PATCH] CRIS architecture update for 2.5.74
> 	
> #	arch/cris/drivers/usb-host.c	1.11    ->         (deleted)      
> #	arch/cris/drivers/usb-host.h	1.2     ->         (deleted)      

Is there going to be a future update for this, or have you all dropped
USB support for CRIS?

thanks,

greg k-h
