Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbUBUAf3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUBUAf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:35:28 -0500
Received: from m013-078.nv.iinet.net.au ([203.217.13.78]:2832 "EHLO
	mail.adixein.com") by vger.kernel.org with ESMTP id S261456AbUBUAfT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:35:19 -0500
From: "Elliot Mackenzie" <macka@adixein.com>
To: "'Randy.Dunlap'" <rddunlap@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: Panic booting from USB disk in ioremap.c (line 81)
Date: Sat, 21 Feb 2004 10:36:11 +1000
Keywords: macka@adixein.com
Message-ID: <001501c3f812$b46a7000$4301a8c0@waverunner>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20040220161950.40bc8fbd.rddunlap@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As enumerated below:
| Calling initcall 0xc03f7e19 pcibios_init
| Calling initcall 0xc03f819c netdev_init
| Calling initcall 0xc03f1e7c chr_dev_init
| Calling initcall 0xc03e7084 i8259_init_sysfs
| Calling initcall 0xc03e7101 init_timer_sysfs
| Calling initcall 0xc03e90e2 sbf_init

Cheers,
Elliot.


