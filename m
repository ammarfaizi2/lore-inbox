Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbTF1FkP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 01:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbTF1FkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 01:40:15 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:4879 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S264493AbTF1FkM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 01:40:12 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.73-mm2 drivers/net/pcmcia/nmclan_cs compile problem
Date: Sat, 28 Jun 2003 13:50:12 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306281318.42517.mflt1@micrologica.com.hk>
Cc: Andrew Morton <akpm@digeo.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/pcmcia/nmclan_cs.c: In function `nmclan_config':
drivers/net/pcmcia/nmclan_cs.c:714: parse error before `*'
drivers/net/pcmcia/nmclan_cs.c:723: `tuple' undeclared (first use in this function)
drivers/net/pcmcia/nmclan_cs.c:723: (Each undeclared identifier is reported only once
drivers/net/pcmcia/nmclan_cs.c:723: for each function it appears in.)
drivers/net/pcmcia/nmclan_cs.c:724: `buf' undeclared (first use in this function)
drivers/net/pcmcia/nmclan_cs.c:728: `last_ret' undeclared (first use in this function)
drivers/net/pcmcia/nmclan_cs.c:728: `last_fn' undeclared (first use in this function)
drivers/net/pcmcia/nmclan_cs.c:730: `parse' undeclared (first use in this function)
drivers/net/pcmcia/nmclan_cs.c:741: `i' undeclared (first use in this function)
drivers/net/pcmcia/nmclan_cs.c:747: `ioaddr' undeclared (first use in this function)
drivers/net/pcmcia/nmclan_cs.c:783: `lp' undeclared (first use in this function)
make[3]: *** [drivers/net/pcmcia/nmclan_cs.o] Error 1
make[2]: *** [drivers/net/pcmcia] Error 2

Regards
Michael
-- 
Powered by linux-2.5.73-mm1, compiled with gcc-2.95-3 - not fancy but rock solid

My current linux related activities:
- Test development and testing of swsusp
- Everyday usage of 2.5 kernel

More info on the 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt


