Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbTCTOGv>; Thu, 20 Mar 2003 09:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbTCTOGv>; Thu, 20 Mar 2003 09:06:51 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:61681 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S261474AbTCTOGu>; Thu, 20 Mar 2003 09:06:50 -0500
X-KENId: 00003529KEN0072C10B
X-KENRelayed: 00003529KEN0072C10B@PCDR800
Date: Thu, 20 Mar 2003 15:14:21 +0100
From: "Christoph Baumann" <cb@sorcus.com>
Subject: ptrace patch
To: <linux-kernel@vger.kernel.org>
Reply-To: "Christoph Baumann" <cb@sorcus.com>
Message-Id: <001d01c2eeeb$02112b00$2265a8c0@dirtyentw>
Mime-Version: 1.0
Content-Type: text/plain;
   charset="iso-8859-1"
X-Priority: 3
Organization: SORCUS Computer GmbH
Content-Transfer-Encoding: 7bit
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:
The ptrace patch at
http://www.hardrock.org/kernel/2.4.20/linux-2.4.20-ptrace.patch does not
seem to work.
I tried the exploit at http://sinuspl.net/ptrace/isec-ptrace-kmod-exploit.c
on a machine running the patched kernel and it still brought up a root
shell.


Mit freundlichen Gruessen / Best regards
Dipl.-Phys. Christoph Baumann
---
SORCUS Computer GmbH
Im Breitspiel 11 c
D-69126 Heidelberg

Tel.: +49(0)6221/3206-0
Fax: +49(0)6221/3206-66

