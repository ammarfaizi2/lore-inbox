Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269376AbUIIIzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269376AbUIIIzf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 04:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269378AbUIIIzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 04:55:35 -0400
Received: from mf2.realtek.com.tw ([220.128.56.22]:21764 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S269376AbUIIIz1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 04:55:27 -0400
Message-ID: <009901c4964a$be2468e0$8b1a13ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: <linux-kernel@vger.kernel.org>
Subject: What File System supports Application XIP
Date: Thu, 9 Sep 2004 16:55:18 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at
 2004/09/09 =?Big5?B?pFWkyCAwNDo1NjoyMg==?=,
	Serialize by Router on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at 2004/09/09
 =?Big5?B?pFWkyCAwNDo1NjoyMw==?=,
	Serialize complete at 2004/09/09 =?Big5?B?pFWkyCAwNDo1NjoyMw==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi there,
We are developing embedded Linux system. Performance is our consideration.
We hope some applications can run as fast as possible,
and are think if they can be put in a filesystem image, which resides in
RAM, and run in XIP (eXecute In Place)  manners.
I know that Cramfs has supported Application XIP. Is there any other FS that
also supports it? Ramdisk? Ramfs? Romfs?

Thanks and regards,
Colin



