Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbWGIL7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbWGIL7K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 07:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbWGIL7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 07:59:10 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:9678 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S1030440AbWGIL7I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 07:59:08 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(59.95.0.168):SA:0(-102.4/1.7):. Processed in 3.160831 secs Process 30391)
From: "Abu M. Muttalib" <abum@aftek.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Robert Hancock" <hancockr@shaw.ca>, <chase.venters@clientec.com>,
       <kernelnewbies@nl.linux.org>, <linux-newbie@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "linux-mm" <linux-mm@kvack.org>
Subject: RE: Commenting out out_of_memory() function in __alloc_pages()
Date: Sun, 9 Jul 2006 17:33:22 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMOEFDDCAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
In-reply-to: <1152446997.27368.52.camel@localhost.localdomain>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Use less memory ?
>
>You can play with /proc/sys/vm/overcommit_ratio. That is set at 50%
>which is usually a good safe value with swap. If you know the kernel and
>kernel memory will be 20% of memory worst case you can set it to 80 and
>so on.

Thanks again.

Can you please elaborate again on the last line!.

Regards,
Abu.

