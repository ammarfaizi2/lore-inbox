Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030454AbWGILnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbWGILnx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 07:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbWGILnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 07:43:53 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:54730 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S1030458AbWGILnw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 07:43:52 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(59.95.0.168):SA:0(-102.4/1.7):. Processed in 1.809383 secs Process 28211)
From: "Abu M. Muttalib" <abum@aftek.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Robert Hancock" <hancockr@shaw.ca>, <chase.venters@clientec.com>,
       <kernelnewbies@nl.linux.org>, <linux-newbie@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "linux-mm" <linux-mm@kvack.org>
Subject: RE: Commenting out out_of_memory() function in __alloc_pages()
Date: Sun, 9 Jul 2006 17:18:06 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMAEFDDCAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
In-reply-to: <1152446107.27368.45.camel@localhost.localdomain>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It will refuse to load the program if that would use enough memory that
>the system cannot be sure it will not run out of memory having done so.
>You probably need a lot more swap.

thanks for ur reply..

but I am running the application on an embedded device and have no swap..

what do I need to do in this case??

Regards,
Abu.



