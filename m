Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTKVJWG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 04:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbTKVJWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 04:22:06 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:13836 "EHLO w.ods.org")
	by vger.kernel.org with ESMTP id S262129AbTKVJWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 04:22:03 -0500
Date: Sat, 22 Nov 2003 10:21:43 +0100
From: Willy Tarreau <willy@w.ods.org>
To: marcelo.tosatti@cyclades.com
Cc: jgarzik@pobox.com, davem@redhat.com, linux-kernel@vger.kernel.org,
       bonding-devel@lists.sourceforge.net
Subject: [PATCH-2.4] fix 2 broken links in bonding documentation
Message-ID: <20031122092143.GA17774@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I've received two mails recently reporting broken links in the bonding
documentation. It would be nice if this could be fixed in 2.4.23. Here
is the patch. I have verified that they currently work.

Cheers,
Willy


--- linux-2.4.23-rc1/Documentation/networking/bonding.txt~	Mon Sep 22 04:48:33 2003
+++ linux-2.4.23-rc1/Documentation/networking/bonding.txt	Sat Nov 22 10:14:02 2003
@@ -973,13 +973,12 @@
 You will also find a lot of information regarding Ethernet, NWay, MII, etc. at
 www.scyld.com.
 
-For new versions of the driver, patches for older kernels and the updated
-userspace tools, take a look at Willy Tarreau's site :
+Patches for 2.2 kernels are at Willy Tarreau's site :
  - http://wtarreau.free.fr/pub/bonding/
- - http://www-miaif.lip6.fr/willy/pub/bonding/
+ - http://www-miaif.lip6.fr/~tarreau/pub/bonding/
 
 To get latest informations about Linux Kernel development, please consult
 the Linux Kernel Mailing List Archives at :
-   http://boudicca.tux.org/hypermail/linux-kernel/latest/
+   http://www.ussg.iu.edu/hypermail/linux/kernel/
 
 -- END --


