Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132127AbRCaDOA>; Fri, 30 Mar 2001 22:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132130AbRCaDNt>; Fri, 30 Mar 2001 22:13:49 -0500
Received: from [210.107.128.31] ([210.107.128.31]:386 "EHLO mail.icu.ac.kr")
	by vger.kernel.org with ESMTP id <S132127AbRCaDNm>;
	Fri, 30 Mar 2001 22:13:42 -0500
Message-ID: <016701c0b98e$f4c1cc90$46846bd2@pcroom.sice.icu>
From: =?ks_c_5601-1987?B?s6q787/B?= <nso@icu.ac.kr>
To: <linux-kernel@vger.kernel.org>
Subject: ACPI poweroff problem with 2.4.x on VIA chipset M/B
Date: Sat, 31 Mar 2001 12:01:58 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

My machine has ASUS CUV4X-E mainboard with Award BIOS.
Using poweroff command, I can power off my machine
with kernel 2.2.x.
But with kernel 2.4.x, this machine doesn't change
to soft-off(S5) state after poweroff command enters.
The last message is "Could not enter S5".
However, old via-chipset mainboard machine has
no problem to poweroff with kernel 2.4.x.

I found 2.3.x VIA chipset patch for ACPI.
Is there 2.4.x VIA chipser pach for ACPI?

Please CC any replies to my email address
becausen I am not subscribed to linux-kernel

- nso
---
SangOg Na



