Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266438AbTABURM>; Thu, 2 Jan 2003 15:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266456AbTABURM>; Thu, 2 Jan 2003 15:17:12 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:35972 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266438AbTABURM>; Thu, 2 Jan 2003 15:17:12 -0500
Message-Id: <4.3.2.7.2.20030102212350.00b5f810@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 02 Jan 2003 21:26:21 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.5.54 typo in arch/i386/Kconfig
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.5.54/arch/i386/Kconfig      2003-01-02 04:21:10.000000000 +0100
+++ linux-2.5.54mw0/arch/i386/Kconfig   2003-01-02 21:22:46.000000000 +0100
@@ -345,7 +345,7 @@

  config X86_PREFETCH
         bool
-       depends on MPENTIUMIII || MP4
+       depends on MPENTIUMIII || MPENTIUM4
         default y

  config X86_SSE2

	Margit 

