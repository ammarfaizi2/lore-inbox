Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWHXLkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWHXLkW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWHXLkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:40:22 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:30177 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S1751161AbWHXLkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:40:21 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(203.129.230.146):SA:0(-102.5/1.7):. Processed in 1.901641 secs Process 3530)
From: "Abu M. Muttalib" <abum@aftek.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Akinobu Mita" <mita@miraclelinux.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: RE: [RFC PATCH] prevent from killing OOM disabled task indo_page_fault()
Date: Thu, 24 Aug 2006 17:14:52 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMCENPDGAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <1156419794.3007.99.camel@localhost.localdomain>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > > The process protected from oom-killer may be killed when
do_page_fault()
> > > runs out of memory. This patch skips those processes as well as init
task.
> >
> > Do we have any patch set to disable OOM all together for linux kernel
> > 2.6.13?
>
> No, its run tme configurable as is selection priority of the processes
> which you want killed, has been for some time.

Will you please elaborate upon your reply.

Thanks,
Abu.



