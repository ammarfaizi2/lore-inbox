Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282080AbRKWHOo>; Fri, 23 Nov 2001 02:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282082AbRKWHOe>; Fri, 23 Nov 2001 02:14:34 -0500
Received: from [202.52.196.218] ([202.52.196.218]:35854 "EHLO And-Or Logic")
	by vger.kernel.org with ESMTP id <S282080AbRKWHOY>;
	Fri, 23 Nov 2001 02:14:24 -0500
From: "Kashif" <kashif@and-or.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel-module version mismatch
Date: Fri, 23 Nov 2001 12:15:58 +0500
Message-ID: <GOEAKAFMBJEILCMEHMLAIEPACAAA.kashif@and-or.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
X-Return-Path: kashif@and-or.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everybody,
 I have recently upgraded from Redhat Linux 7.1 kernel
version 2.4.2 to 2.4.10. I am trying to insert a
driver module "code.o" (which was perfectly fine in the previous kernel)into
the new Kernel. But on insmod i get
an error:-

"kernel-module version mismatch. code.o was compiled
for kernel version 2.4.2-2 while this kernel is
version 2.4.10"

 Although i am able to insert the driver module with
the -f(force) switch. But this results in a faulty
operation of the driver module. Rather i get an OOps message
I have tried recompiling the source of gcc in this new kernel but
that has also not solved this problem. Help will be
appreciated! Thank you.

Kashif!


