Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVENQDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVENQDH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 12:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVENQDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 12:03:06 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:35260 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261432AbVENQDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 12:03:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RYeYrEsuJ2ERNDHHc2A4gz0B57k2sP7MUjnVd7d2XGw4gKn3kqwK1cKJzUqTBBIzUIWhqHRxwvBmLKmIB3O1AwkeSQW+0Cn6Aoz1/aOszZ5+07BPhkO5q1pLjas5QS17NHob+0lWMHe4g7d8t+BLEPlQNBjkjEnVoNHW4zp5gmo=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] DIE "Russel", DIE! 2
Date: Sat, 14 May 2005 20:06:58 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505142006.58691.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Third part of the movie will hit cinemas around 29 Apr 2008. ;-)

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- linux-vanilla/drivers/video/pm3fb.c	2005-05-13 17:55:13.000000000 +0400
+++ linux-russell/drivers/video/pm3fb.c	2005-05-14 19:39:58.000000000 +0400
@@ -5,7 +5,7 @@
  *  Based on code written by:
  *           Sven Luther, <luther@dpt-info.u-strasbg.fr>
  *           Alan Hourihane, <alanh@fairlite.demon.co.uk>
- *           Russel King, <rmk@arm.linux.org.uk>
+ *           Russell King, <rmk@arm.linux.org.uk>
  *  Based on linux/drivers/video/skeletonfb.c:
  *	Copyright (C) 1997 Geert Uytterhoeven
  *  Based on linux/driver/video/pm2fb.c:
