Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271691AbRIGSfo>; Fri, 7 Sep 2001 14:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272698AbRIGSf2>; Fri, 7 Sep 2001 14:35:28 -0400
Received: from metroplex.netnation.com ([204.174.223.60]:48275 "EHLO
	metroplex.netnation.com") by vger.kernel.org with ESMTP
	id <S271691AbRIGSfK>; Fri, 7 Sep 2001 14:35:10 -0400
From: "Attila A Odry" <attilao@netnation.com>
To: <linux-kernel@vger.kernel.org>
Subject: BUG
Date: Fri, 7 Sep 2001 11:42:08 -0700
Message-ID: <NFBBKJCMLKHFOCPABDLICEIMCPAA.attilao@netnation.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sep  6 23:45:25 Outside kernel: skput:over: c01f12c6:1448 put:1448
dev:<NULL>kernel BUG at skbuff.c:93!
Sep  6 23:45:25 Outside kernel: invalid operand: 0000
Sep  6 23:45:25 Outside kernel: CPU:    0

Kernel version 2.4.9 FINAL,  CPU INFO 667Mhz Coppermine 512MB 133Mhz SDRAM

