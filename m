Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265349AbSJPRKQ>; Wed, 16 Oct 2002 13:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265350AbSJPRKQ>; Wed, 16 Oct 2002 13:10:16 -0400
Received: from viefep13-int.chello.at ([213.46.255.15]:5694 "EHLO
	viefep13-int.chello.at") by vger.kernel.org with ESMTP
	id <S265349AbSJPRKP>; Wed, 16 Oct 2002 13:10:15 -0400
Subject: Re: usb CF reader and 2.4.19
From: Joseph Wenninger <jowenn@kde.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021016153431.GC23287@kroah.com>
References: <1034760128.1306.4.camel@jowennmobile> 
	<20021016153431.GC23287@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Oct 2002 19:16:49 +0200
Message-Id: <1034788610.4084.9.camel@jowennmobile>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Am Mit, 2002-10-16 um 17.34 schrieb Greg KH:
...
> 
> sync(1) and then umount(8) doesn't flush everything to the device?
> 

Exactly. If I remount the device it looks like everything is okay, but
if I put it into my notebook instead the CF appears still empty. If I do
the module unloading before I remove the CF from the reader it works. I
don't think that it is the card reader, since it works perfectly with
Windows XP or 2000.

Just for reference I use a ML4-USB card reader/writer from Datafab. It
is a device with 4 slots (each appearing as an own device) for
CF,SM,SD,MS

Kind regards
Joseph Wenninger

