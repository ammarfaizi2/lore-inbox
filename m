Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbTEaMAG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 08:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbTEaMAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 08:00:06 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:32669 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264304AbTEaMAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 08:00:05 -0400
Message-Id: <5.1.0.14.2.20030531141149.00af7a00@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 31 May 2003 14:13:11 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.5.70-bk4 isdn
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      drivers/isdn/i4l/isdn_common.o
drivers/isdn/i4l/isdn_common.c: In function `map_drvname':
drivers/isdn/i4l/isdn_common.c:1981: structure has no member named `drvid'
drivers/isdn/i4l/isdn_common.c: In function `map_namedrv':
drivers/isdn/i4l/isdn_common.c:1988: structure has no member named `drvid'
drivers/isdn/i4l/isdn_common.c: In function `isdn_register_divert':
drivers/isdn/i4l/isdn_common.c:2010: `isdn_command' undeclared (first use 
in this function)
drivers/isdn/i4l/isdn_common.c:2010: (Each undeclared identifier is 
reported only once
drivers/isdn/i4l/isdn_common.c:2010: for each function it appears in.)
make[3]: *** [drivers/isdn/i4l/isdn_common.o] Error 1
make[2]: *** [drivers/isdn/i4l] Error 2
make[1]: *** [drivers/isdn] Error 2

Margit

