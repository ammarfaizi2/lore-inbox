Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbSKRClP>; Sun, 17 Nov 2002 21:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261393AbSKRClP>; Sun, 17 Nov 2002 21:41:15 -0500
Received: from descript.sysdoor.net ([81.91.66.78]:25356 "EHLO jenna")
	by vger.kernel.org with ESMTP id <S261376AbSKRClO>;
	Sun, 17 Nov 2002 21:41:14 -0500
Message-ID: <028901c28ead$10dfbd20$76405b51@romain>
From: "Vergoz Michael" <mvergoz@sysdoor.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: 8139too.c patch for kernel 2.4.19
Date: Mon, 18 Nov 2002 03:49:08 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

The current 8139too.c linux kernel driver dosn't work.
There is the patch for the driver 8139too.c at :

http://descript.sysdoor.net/patch/kernel/2.4.19/8139too.c.diff

It fix some problems with card mode, new hard detection and new card
added.

Please read the diff.

PS : There is something strange with the list... or perhaps me ...

Best regards,
Vergoz Michael
