Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131979AbRCaCjp>; Fri, 30 Mar 2001 21:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132005AbRCaCjf>; Fri, 30 Mar 2001 21:39:35 -0500
Received: from [210.107.128.31] ([210.107.128.31]:13953 "EHLO mail.icu.ac.kr")
	by vger.kernel.org with ESMTP id <S131979AbRCaCjT>;
	Fri, 30 Mar 2001 21:39:19 -0500
Message-ID: <015f01c0b98a$2857c500$46846bd2@pcroom.sice.icu>
From: =?ks_c_5601-1987?B?s6q787/B?= <nso@icu.ac.kr>
To: <linux-kernel@vger.kernel.org>
Subject: 3c905B(cyclone) DHCP delay on boot time
Date: Sat, 31 Mar 2001 11:27:37 +0900
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

I recently upgraded kernel to 2.4.2 on 3 machines.
These machines use DHCP.
2 machines have 3c905B(cyclone) and
1 machine has 3c905c(Tornado).
At boot time, there are over 1 minute delay
to bring up network interface eth0 at 3c905B machines.
There is no problems when booting with kernel 2.2.x
or booting with kernel 2.4.2 on 3c905C machine.

Please CC any replies to my email address
becausen I am not subscribed to linux-kernel

- nso
---
SangOg Na


