Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbVJ2OfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVJ2OfV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 10:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVJ2OfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 10:35:20 -0400
Received: from [69.222.0.20] ([69.222.0.20]:58889 "EHLO usfltd.com")
	by vger.kernel.org with ESMTP id S1751164AbVJ2OfT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 10:35:19 -0400
Date: Sat, 29 Oct 2005 09:36:00 -0500
Message-Id: <200510290936.AA1507856@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
From: "art" <art@usfltd.com>
Reply-To: <art@usfltd.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel-2.6.14-git1 - ieee1394 rev.1334 compilation problem !
X-Mailer: <IMail v8.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kernel-2.6.14-git1 - ieee1394 rev.1334 compilation problem !
....
  CC [M]  drivers/ieee1394/csr.o
  CC [M]  drivers/ieee1394/nodemgr.o
drivers/ieee1394/nodemgr.c: In function ‘nodemgr_suspend_ne’:
drivers/ieee1394/nodemgr.c:1295: error: too many arguments to function ‘ud->device.driver->suspend’
drivers/ieee1394/nodemgr.c: In function ‘nodemgr_resume_ne’:
drivers/ieee1394/nodemgr.c:1318: error: too many arguments to function ‘ud->device.driver->resume’
make[2]: *** [drivers/ieee1394/nodemgr.o] Error 1
make[1]: *** [drivers/ieee1394] Error 2
make: *** [drivers] Error 2

xboom

