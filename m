Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbRG0WDa>; Fri, 27 Jul 2001 18:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbRG0WDU>; Fri, 27 Jul 2001 18:03:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:23024 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265402AbRG0WDL>; Fri, 27 Jul 2001 18:03:11 -0400
Subject: [PATCH] switch_mm() can fail to load ldt on SMP
To: linux-kernel@vger.kernel.org
Cc: "James Washer" <washer@us.ibm.com>, "Judy Barkal" <jbarkal@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF3506F19C.23358660-ON88256A96.0077F4BF@boulder.ibm.com>
From: "Judy Barkal" <jbarkal@us.ibm.com>
Date: Fri, 27 Jul 2001 15:03:15 -0700
X-MIMETrack: Serialize by Router on D03NM015/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 07/27/2001 04:03:16 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Linus' patch is in testing/patch-2.4.8-pre1.

A patch for 2.4.5-7 is available at
http://oss.software.ibm.com/developer/opensource/linux/patches/misc.php

Thanks,
Jim Washer and Judy Barkal
     washer@us.ibm.com   jbarkal@us.ibm.com

