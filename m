Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWGIOak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWGIOak (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 10:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWGIOak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 10:30:40 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:11746 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S932458AbWGIOai
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 10:30:38 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(59.95.0.168):SA:0(-102.4/1.7):. Processed in 1.562339 secs Process 16603)
From: "Abu M. Muttalib" <abum@aftek.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Robert Hancock" <hancockr@shaw.ca>, <chase.venters@clientec.com>,
       <kernelnewbies@nl.linux.org>, <linux-newbie@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "linux-mm" <linux-mm@kvack.org>
Subject: RE: Commenting out out_of_memory() function in __alloc_pages()
Date: Sun, 9 Jul 2006 20:04:52 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMIEFJDCAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
In-reply-to: <44B0F0AA.20708@yahoo.com.au>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Abu, I guess you have turned on CONFIG_EMBEDDED and disabled everything
>you don't need, turned off full sized data structures, removed everything
>else you don't need from the kernel config, turned off kernel debugging
>(especially slab debugging).

Do you mean that I have configured kernel with CONFIG_EMBEDDED option??

>If you still have problems, what does /proc/slabinfo tell you when running
>your application under both 2.4 and 2.6?

Will find out the differences..

Regards,
Abu.
