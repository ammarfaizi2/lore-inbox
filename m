Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272147AbRHVWXb>; Wed, 22 Aug 2001 18:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272146AbRHVWXV>; Wed, 22 Aug 2001 18:23:21 -0400
Received: from ch-12-44-139-249.lcisp.com ([12.44.139.249]:42624 "HELO
	dual.lcisp.com") by vger.kernel.org with SMTP id <S272148AbRHVWXG>;
	Wed, 22 Aug 2001 18:23:06 -0400
From: "Kevin Krieser" <kkrieser_list@footballmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel Locking Up
Date: Wed, 22 Aug 2001 17:23:16 -0500
Message-ID: <NDBBLFLJADKDMBPPNBALAEGFFDAA.kkrieser_list@footballmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010822123350.D20693@mindspring.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had some lockups too when I went to the 2.4 kernels.  I ended up removing
a SCSI card, and adding a fan to cool off my computer.  I was up for 12 days
recently before I noticed that my USB printer wasn't working, and I saw I
had compiled the wrong USB controllers into my kernel.  It has now been up
for almost 4 days now with a properly configured stock 2.4.8 kernel.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Tim Walberg
Sent: Wednesday, August 22, 2001 12:34 PM
To: Alan Cox
Cc: Travis Shirk; Linux Kernel Mailing List
Subject: Re: Kernel Locking Up


Yes, I have seen it happen a couple times before
I started X, within a couple minutes of boot completing.

		tw

