Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130110AbQL2K2q>; Fri, 29 Dec 2000 05:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130884AbQL2K2g>; Fri, 29 Dec 2000 05:28:36 -0500
Received: from hnlmail3.hawaii.rr.com ([24.25.227.37]:28170 "EHLO
	hawaii.rr.com") by vger.kernel.org with ESMTP id <S130110AbQL2K2Z>;
	Fri, 29 Dec 2000 05:28:25 -0500
From: "Ryan Sizemore" <ryan831@usa.net>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with ATX halt
Date: Thu, 28 Dec 2000 23:59:06 -1000
Message-ID: <NEBBIFHONDNEGJDKODONAEIDCDAA.ryan831@usa.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   I am new this whole 'posting to the mailing list' thing, so please excuse
any obvious mistakes.
   I have a comp. running mandrake 7.2, and when i go to power it down, it
gives me a screen full of errors, including a stackdump. It happens as the
very last thing (including being after the file system is unmounted, so I
highly doubt that the error is recorded somewhere. But i will hand-copy the
stack for whomever thinks it may be useful. The error is reproduced every
time, without equivication. Any insight or questions are much apriciated.
The motherboard is a Soyo 5EMA+ r1.0 w/ ETEQ EQ82C6638 Chipset, and it has
an Award BIOS.
Thanks in Advance.

--Ryan Sizemore

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
