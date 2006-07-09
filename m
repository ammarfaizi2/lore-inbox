Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030488AbWGINIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030488AbWGINIL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 09:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030490AbWGINIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 09:08:11 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:40663 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S1030488AbWGINIJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 09:08:09 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(59.95.0.168):SA:0(-102.4/1.7):. Processed in 1.131264 secs Process 7304)
From: "Abu M. Muttalib" <abum@aftek.com>
To: "Willy Tarreau" <w@1wt.eu>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Robert Hancock" <hancockr@shaw.ca>,
       <chase.venters@clientec.com>, <kernelnewbies@nl.linux.org>,
       <linux-newbie@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "linux-mm" <linux-mm@kvack.org>
Subject: RE: Commenting out out_of_memory() function in __alloc_pages()
Date: Sun, 9 Jul 2006 18:42:23 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMCEFIDCAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
In-reply-to: <20060709121511.GD2037@1wt.eu>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It's explained in Documentation/filesystems/proc.txt. This file know far
>ore things than me :-)

I tried with overcommit_ratio=100 and overcommit_memory=2 in that sequence.

but the applications were killed. :-(

Regards,
Abu.
