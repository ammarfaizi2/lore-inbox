Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130188AbRAYRCT>; Thu, 25 Jan 2001 12:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130920AbRAYRCK>; Thu, 25 Jan 2001 12:02:10 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:60937 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S130188AbRAYRCG>; Thu, 25 Jan 2001 12:02:06 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDF6D@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Thunder from the hill'" <thunder@ngforever.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Teledat USB 2 a/b
Date: Thu, 25 Jan 2001 09:01:50 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some USB ISDN TAs work with Linux-USB.
See http://www.qbik.ch/usb/devices/ + Device Overview + Comm.
Several are listed there.
The Teledat is not listed, so it may or may not work.

You could try attaching the device with the "acm" driver
loaded to see if the acm driver claims the device.

~Randy
_______________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
-----------------------------------------------

> From: Thunder from the hill [mailto:thunder@ngforever.de]
> 
> Is there support for external USB ISDN boxes like the Teledat 
> USB 2 a/b?
> I don't really know this box, but there's someone asking for it...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
