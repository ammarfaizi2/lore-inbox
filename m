Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129892AbQKISLV>; Thu, 9 Nov 2000 13:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129900AbQKISLL>; Thu, 9 Nov 2000 13:11:11 -0500
Received: from baucis.sc.intel.com ([143.183.152.22]:49164 "EHLO
	baucis.sc.intel.com") by vger.kernel.org with ESMTP
	id <S129892AbQKISKz>; Thu, 9 Nov 2000 13:10:55 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDC86@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Steven_Snyder@3com.com'" <Steven_Snyder@3com.com>,
        linux-kernel@vger.kernel.org
Subject: RE: Porting Linux v2.2.x Ethernet driver to v2.4.x?
Date: Thu, 9 Nov 2000 10:10:34 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Search the lkml archives.  Here are 2 instances
to find:

from jamal, 2000-jan-6: [ANNOUNCE] SOFTNETing Network Drivers HOWTO

from kuznet, 2000-feb-14: "softnet" drivers: an attempt to clarify

from dave miller, 2000-feb-9: new network driver interface changes, README
  http://www.uwsg.indiana.edu/hypermail/linux/kernel/0002.1/0408.html
from jamal, 2000-feb-10:      ditto
  http://www.uwsg.indiana.edu/hypermail/linux/kernel/0002.1/0461.html
from dave miller, 2000-feb-12: ditto

_______________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
----------------------------------------------- 

> -----Original Message-----
> From: Steven_Snyder@3com.com [mailto:Steven_Snyder@3com.com]
> Sent: Thursday, November 09, 2000 10:01 AM
> To: linux-kernel@vger.kernel.org
> Subject: Porting Linux v2.2.x Ethernet driver to v2.4.x?
> 
> 
> 
> 
> Hello.
> 
> I am about to modify a Linux v2.2.x-compatible Ethernet 
> driver to allow it to
> work in the new v2.4.x kernel.  Are there any documents which 
> describe the
> differences in the device driver models (particularly PCI and 
> Ethernet) of the 2
> kernel versions?  If so, where can I find them?
> 
> Thank you.
> 
> (Sorry about the advertisement below.)
> 
> 
> 
> 
> PLANET PROJECT will connect millions of people worldwide 
> through the combined
> technology of 3Com and the Internet. Find out more and register now at
> http://www.planetproject.com
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
