Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbRCAPrL>; Thu, 1 Mar 2001 10:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129667AbRCAPrD>; Thu, 1 Mar 2001 10:47:03 -0500
Received: from [62.90.5.51] ([62.90.5.51]:48903 "EHLO salvador.shunra.co.il")
	by vger.kernel.org with ESMTP id <S129664AbRCAPqw>;
	Thu, 1 Mar 2001 10:46:52 -0500
Message-ID: <F1629832DE36D411858F00C04F24847A11DECF@SALVADOR>
From: Ofer Fryman <ofer@shunra.co.il>
To: "'kernel@kvack.org'" <kernel@kvack.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Intel-e1000 for Linux 2.0.36-pre14
Date: Thu, 1 Mar 2001 17:51:30 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="WINDOWS-1255"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need a giga fiber PMC cards for linux2.0.36-pre14, the only cards I know
are either Intel based or level-one lxt-1001 card, the level-one lxt-1001
has very bad performance so I cannot use it.

Thanks,
Ofer

-----Original Message-----
From: kernel@kvack.org [mailto:kernel@kvack.org]
Sent: Thursday, March 01, 2001 5:31 PM
To: Ofer Fryman
Cc: 'linux-kernel@vger.kernel.org'
Subject: Re: Intel-e1000 for Linux 2.0.36-pre14


On Thu, 1 Mar 2001, Ofer Fryman wrote:

> I managed to compiled e1000 for Linux 2.0.36-pre14, I can also load it
> successfully. 
> With the E1000_IMS_RXSEQ bit set in IMS_ENABLE_MASK I get endless
interrupts
> and the computer freezes, without this bit set it works but I cannot
receive
> or send anything.

Intel refuses to provide complete documentation for any of their ethernet
cards.  I recommend purchasing alternative products from vendors like 3com
and National Semiconduct who are cooperative in providing data needed by
the development community.


		-ben

