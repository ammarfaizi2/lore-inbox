Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTDCVbd 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 16:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263421AbTDCVbc 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 16:31:32 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:41749 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S263424AbTDCVbU 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 16:31:20 -0500
Message-ID: <009c01c2fa29$f7b2d290$2e77c23e@pentium4>
From: "Jonathan Vardy" <jonathanv@explainerdc.com>
To: "Peter L. Ashford" <ashford@sdsc.edu>,
       "Jonathan Vardy" <jonathan@explainerdc.com>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.30.0304030858080.20118-100000@multivac.sdsc.edu>
Subject: Re: RAID 5 performance problems
Date: Thu, 3 Apr 2003 23:42:47 +0200
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

> The ONLY reason that I can think of to use round cables would be for
> looks.  From a performance or reliability standpoint, they are a waste of
> money.  I routinely build systems with dual 8-channel IDE RAID cards
> (3Ware 7500-8) and 16 disks, and ONLY use flat cables.

I use rounded cables in my case for a few reasons:
- The distance between my promise and my drives is small yet the promise
cables are long, the rounded cables I have are 12" long and fit very neatly
- The promise cables had two IDE connectors but I only wanted to put one
drive per channel; the rounded cables are single cables
- Air flow; because of my small casing the flat promise cables were
contricting the airflow quite a bit, the rounded less
- flexibility; I found the flat cables hard to bend in to place whereas the
round cables you could twist easily

I've added a link which should make it clear that rounded cables in my case
are a benefit to me. What I was worried about was that they could be
inferior quality and thus be a factor in my raid performance.

http://www.datzegik.com/DSC00056.JPG

