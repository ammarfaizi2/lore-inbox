Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284182AbRLASdr>; Sat, 1 Dec 2001 13:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284194AbRLASdh>; Sat, 1 Dec 2001 13:33:37 -0500
Received: from [199.29.68.123] ([199.29.68.123]:11794 "EHLO MailAndNews.com")
	by vger.kernel.org with ESMTP id <S284182AbRLASdb>;
	Sat, 1 Dec 2001 13:33:31 -0500
X-WM-Posted-At: MailAndNews.com; Sat, 1 Dec 01 13:33:25 -0500
Message-ID: <010401c17a96$a994aa20$0500a8c0@myroom>
From: "Matt Schulkind" <mschulkind@mailandnews.com>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: GeForce3 framebuffer suport
Date: Sat, 1 Dec 2001 13:33:24 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone attempted to add framebuffer support for the GeForce3 into the
prexisting riva fb drivers? I tried just added the PCI ID and adjusting all
the tables, but when I loaded the driver, the picture looked like the bit
depths or something was off. I also coudln't find any documentation to try
hacking it my self. Anyone know what the differences are between the 2D in
the GeForce2 and GeForce2 are?

-Matt Schulkind

