Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269994AbTGYKNt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 06:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270585AbTGYKNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 06:13:49 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:12548
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S269994AbTGYKNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 06:13:47 -0400
Date: Fri, 25 Jul 2003 03:20:48 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Tomi Lapinlampi <lapinlam@vega.lnet.lut.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: Nokia A036 and the GPL
In-Reply-To: <20030725102010.GF24789@vega.lnet.lut.fi>
Message-ID: <Pine.LNX.4.10.10307250319000.23423-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tomi,

Who cares, the world according to Roman .. it all should be free and to
pursue litigation of any kind will offend people and they will not use
Linux.

-a

On Fri, 25 Jul 2003, Tomi Lapinlampi wrote:

> 
> Hi,
> 
> A few weeks ago Andrew Miklas wrote about a potential GPL violation
> with the Linksys WRT54G wireless access point. I may have something
> that falls into the same category, namely the Nokia A036.
> 
> Nokia A036 is a 802.11b access point, small in size and with some
> nice features. Besides using a web interface it's possible to
> telnet into the device to configure it. Here's a sample session:
> 
> LocalAP login: root
> Password: 
> #
> # uname -a
> Linux LocalAP 2.4.17-uc0 #17 Tue Nov 5 20:12:26 CST 2002 armv4l unknown
> # grep -v
> BusyBox v0.51 (2002.11.05-12:11+0000) multi-call binary
> 
> Usage: grep [-ihHnqvs] pattern [files...]
> 
> # cat /proc/cpuinfo
> Processor       : ARM Arm940 rev 1 (v4l)
> BogoMIPS        : 89.49
> Hardware        : POLDHU
> Revision        : 0000
> Serial          : 0000000000000000
> 
> # cat /proc/version
> Linux version 2.4.17-uc0 (root@guava-004.gemtek.com.tw) (gcc version 2.95.3.2 20010315 (release)) #17 Tue Nov 5 20:12:26 CST 2002
> 
> So, it's quite clear that this access point runs Linux and BusyBox.
> It does not use modules - the kernel seems to be static. Therefore
> I must assume that the drivers for the wireless interface are
> free software too.
> 
> I have the factory package and product CD for the A036, but there's
> no sign of the GNU GPL anywhere - or pointers where to get the
> source code - just the normal Nokia copyright texts and disclaimers.
> 
> Having the source code would be useful in learning how this device
> works. It might also be handy for customizing this device. 
> 
> How should I (and the Linux community) proceed to solve this problem?
> Perhaps someone at Nokia is reading this?
> 
> Regards,
> 
> Tomi Lapinlampi
> 
> -- 
> You can decide: live with free software or with only one evil company left?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

