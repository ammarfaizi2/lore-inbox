Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130311AbRAHTNx>; Mon, 8 Jan 2001 14:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131574AbRAHTNn>; Mon, 8 Jan 2001 14:13:43 -0500
Received: from smtp.alacritech.com ([209.10.208.82]:30982 "EHLO
	smtp.alacritech.com") by vger.kernel.org with ESMTP
	id <S130311AbRAHTNk>; Mon, 8 Jan 2001 14:13:40 -0500
From: "Christopher Harrer" <charrer@alacritech.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: Modules Question
Date: Mon, 8 Jan 2001 14:13:20 -0500
Message-ID: <POELKPJGDHAPIPMEMHGAGELIDJAA.charrer@alacritech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've built a module I'm trying to run on various (2.2.x) levels of the
kernel.  I compiled the module against a 2.2.18 Source Tree.  I strip out
the __module_kernel_version symbol and re-link the module on the target
system to get the __module_kernel_version symbol in it.  My problem is that
I cannot run the module on any version of the kernel other than the version
the module was compiled against without getting a slew of unresolved
symbols.  Can anyone please provide a little advice?

Thanks!

Chris


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
