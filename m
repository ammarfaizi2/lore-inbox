Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311569AbSCVJsQ>; Fri, 22 Mar 2002 04:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311637AbSCVJsG>; Fri, 22 Mar 2002 04:48:06 -0500
Received: from [211.63.31.129] ([211.63.31.129]:49630 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S311569AbSCVJrv>; Fri, 22 Mar 2002 04:47:51 -0500
Message-ID: <001b01c1d186$f5c9a3e0$a31f3fd3@sjahn>
From: "Sangjoon Ahn" <sjahn@zooin.net>
To: <linux-kernel@vger.kernel.org>
Subject: Linux tuning issue for udp live streaming application
Date: Fri, 22 Mar 2002 18:50:12 +0900
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there.

We are currently implmenting the live streaming solution on Redhat 7.2
(Kernel 2.4.18) + 1 Gigabit NIC(Intel Pro/1000 XF Server Adapter). Our
solution transfers a 1Mbps data to many receiver using UDP protocol.

We want to have the better performance than 500Mbps throughput measured for
testing .

I want to know the tuning issues suitable for our solution. Also, we want to
use a zero-copy api of udp, but we don't know usage of the api and whether
it is support on Linux kernel 2.4.18. If it is supported, how can I find it.

Please let me know the information.


Thanks in advance.


-------------------------------------------------------------------
  Sangjoon Ahn                                        E-Mail :
sjahn@zooin.net
  ZooIn.net                                                  Tel :
+82-2-2057-2262
  3F, Keukdonggangnam B/D, 553 Dokok-dong,   Fax : +82-2-2057-0318
  Gangnam-gu, Seoul 135-270, Korea       Mobile : +82-11-305-8230
-------------------------------------------------------------------


