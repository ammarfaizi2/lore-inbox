Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbUKBOTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbUKBOTJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 09:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbUKBOTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 09:19:09 -0500
Received: from [212.209.10.221] ([212.209.10.221]:43750 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S262950AbUKBORF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 09:17:05 -0500
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       "Mikael Starvik" <mikael.starvik@axis.com>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: RE: [PATCH 4/10] CRIS architecture update - IDE
Date: Tue, 2 Nov 2004 15:16:51 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C7492@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66801AF70DD@exmail1.se.axis.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I'll make the patches apply to that instead.

-----Original Message-----
From: Bartlomiej Zolnierkiewicz [mailto:bzolnier@gmail.com] 
Sent: Tuesday, November 02, 2004 3:15 PM
To: Mikael Starvik
Cc: linux-kernel@vger.kernel.org; akpm@osdl.org
Subject: Re: [PATCH 4/10] CRIS architecture update - IDE


It conflicts with changes in 2.6.10-rc1 / current -bk.

On Tue, 2 Nov 2004 14:04:39 +0100, Mikael Starvik
<mikael.starvik@axis.com> wrote:
> Update CRIS IDE driver for 2.6.9.
> 
> Signed-Off-By: starvik@axis.com
> 
> /Mikael

