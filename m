Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129958AbRBBQdE>; Fri, 2 Feb 2001 11:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129990AbRBBQco>; Fri, 2 Feb 2001 11:32:44 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:3588 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129958AbRBBQck>; Fri, 2 Feb 2001 11:32:40 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDFDA@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Rogerio Brito'" <rbrito@iname.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: More on the VIA KT133 chipset misbehaving in Linux
Date: Fri, 2 Feb 2001 08:30:59 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Rogerio Brito [mailto:rbrito@iname.com]
> 
> 	While I don't have problems with the Duron above, I do have a
> 	486 here with 8MB of memory that I intend to use as a router
> 	for my local LAN, but 2.4.0 only recognizes 7MB, while 2.2.18
> 	recognizes all 8MB. Under 2.4.0 (I haven't tried 2.4.1 yet), I
> 	used a mem=8M option and it worked fine, but I don't know if
> 	this is indeed safe or not (I'd guess that it would be, since
> 	the 2.2 kernels use all memory, but you never know).

Fixed in 2.4.1 and its pre-patches.

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
