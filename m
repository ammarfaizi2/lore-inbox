Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVCLRfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVCLRfg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 12:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVCLRfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 12:35:36 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:6545 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261312AbVCLRf2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 12:35:28 -0500
Message-ID: <4233285C.4000707@drzeus.cx>
Date: Sat, 12 Mar 2005 18:35:24 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-6261-1110649013-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>, Ian Molton <spyro@f2s.com>,
       Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH][MMC][7/6] Secure Digital (SD) support : Copyright
References: <422701A0.8030408@drzeus.cx> <20050305113730.B26541@flint.arm.linux.org.uk> <4229A4B4.1000208@drzeus.cx> <20050305124420.A342@flint.arm.linux.org.uk> <422A5E1C.2050107@drzeus.cx>
In-Reply-To: <422A5E1C.2050107@drzeus.cx>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-6261-1110649013-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

I suppose a copyright notice is appropriate to indicate the origins of
the SD additions.

mmc.c is the only file with substancial changes so it should be enough
with a notice there.


--=_hades.drzeus.cx-6261-1110649013-0001-2
Content-Type: text/x-patch; name="mmc-sd-copyright.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-sd-copyright.patch"

Index: linux-sd/drivers/mmc/mmc.c
===================================================================
--- linux-sd/drivers/mmc/mmc.c	(revision 141)
+++ linux-sd/drivers/mmc/mmc.c	(working copy)
@@ -2,6 +2,8 @@
  *  linux/drivers/mmc/mmc.c
  *
  *  Copyright (C) 2003-2004 Russell King, All Rights Reserved.
+ *  SD support Copyright (C) 2004 Ian Molton, All Rights Reserved.
+ *  SD support Copyright (C) 2005 Pierre Ossman, All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as

--=_hades.drzeus.cx-6261-1110649013-0001-2--
