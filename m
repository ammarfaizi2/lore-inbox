Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbUKBOlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUKBOlL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 09:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbUKBOlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 09:41:10 -0500
Received: from [212.209.10.221] ([212.209.10.221]:56787 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S261928AbUKBOLg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 09:11:36 -0500
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       "Mikael Starvik" <mikael.starvik@axis.com>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: RE: [PATCH 8/10] CRIS architecture update - Move drivers
Date: Tue, 2 Nov 2004 15:10:34 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C7491@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66801AF70B9@exmail1.se.axis.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure. I'll wait a few days for more comments like this and then send updated
patches.

/Mikael

-----Original Message-----
From: Bartlomiej Zolnierkiewicz [mailto:bzolnier@gmail.com] 
Sent: Tuesday, November 02, 2004 2:56 PM
To: Mikael Starvik
Cc: linux-kernel@vger.kernel.org; akpm@osdl.org
Subject: Re: [PATCH 8/10] CRIS architecture update - Move drivers


Mikael,

could you rename Etrax IDE driver to something less confusing than ide.c
(ie. ide-etrax.c).

Thanks.

On Tue, 2 Nov 2004 14:04:51 +0100, Mikael Starvik
<mikael.starvik@axis.com> wrote:
> This is a shell script to move drivers from arch/cris/arch-v10/drivers to
> e.g. drivers/net/cris/v10. This must be applied after patch 1-7 and before
> patch 9.
> 
> Let me know if you prefer this as a big diff instead.
> 
> Signed-Off-By: starvik@axis.com
> 
> /Mikael

