Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbVJYGrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbVJYGrP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 02:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbVJYGrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 02:47:15 -0400
Received: from mf2.realtek.com.tw ([220.128.56.22]:11532 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S1751474AbVJYGrO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 02:47:14 -0400
Message-ID: <034801c5d92f$e1211860$106215ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: <linux-kernel@vger.kernel.org>
Subject: "disable printk" will make console disappear
Date: Tue, 25 Oct 2005 14:46:51 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/10/25 =?Bog5?B?pFWkyCAwMjo0Njo1MQ==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/10/25 =?Bog5?B?pFWkyCAwMjo0Njo1Mw==?=,
	Serialize complete at 2005/10/25 =?Bog5?B?pFWkyCAwMjo0Njo1Mw==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
I found that if I disable "Enable support for printk", the console will
disappear.
I donot think login and shell applications have any connection with
"printk". Why disabling printk will make the console disappear?

Regards,
Colin

