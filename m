Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbTATJYy>; Mon, 20 Jan 2003 04:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbTATJYy>; Mon, 20 Jan 2003 04:24:54 -0500
Received: from fmr05.intel.com ([134.134.136.6]:58596 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S262838AbTATJYx>; Mon, 20 Jan 2003 04:24:53 -0500
Message-ID: <957BD1C2BF3CD411B6C500A0C944CA2602D9D4D8@pdsmsx32.pd.intel.com>
From: "Guo, Min" <min.guo@intel.com>
To: stanley.wang@linux.co.intel.com, Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: RE: [Pcihpd-discuss] How about use sysfs instead of pcihpfs?
Date: Mon, 20 Jan 2003 17:31:24 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think it is a good idea....

Guo Min 
The content of this email message solely contains my own personal views,
and not those of my employer.

-----Original Message-----
From: stanley.wang@linux.co.intel.com
[mailto:stanley.wang@linux.co.intel.com]
Sent: Monday, January 20, 2003 5:22 PM
To: Greg KH
Cc: Linux Kernel Mailing List; PCI_Hot_Plug_Discuss
Subject: [Pcihpd-discuss] How about use sysfs instead of pcihpfs?


Hi, Greg!
After reading the pci_hotplug_core.c, I found there are many codes 
that are used to implement the pcihpfs. And how about using sysfs instead
of pcihpfs ? I think it could make the pci_hotplug_core.c smaller. Another
pro is that we will nerver be bothered by the pcihpfs' bug.
How you think about it?

Regards,
Stanley Wang

-- 
Opinions expressed are those of the author and do not represent Intel
Corporation




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
_______________________________________________
Pcihpd-discuss mailing list
Pcihpd-discuss@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/pcihpd-discuss
