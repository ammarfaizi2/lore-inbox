Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271858AbRIUIHg>; Fri, 21 Sep 2001 04:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271836AbRIUIH0>; Fri, 21 Sep 2001 04:07:26 -0400
Received: from ns1.jasper.com ([64.19.21.34]:54183 "EHLO ersfirep1")
	by vger.kernel.org with ESMTP id <S271858AbRIUIHJ>;
	Fri, 21 Sep 2001 04:07:09 -0400
From: "Radivoje Todorovic" <radivojet@jaspur.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.0 and QoS installation
Date: Fri, 21 Sep 2001 03:06:45 -0500
Message-ID: <NEBBJJBDIJBKDNLLLHFCEELOCCAA.radivojet@jaspur.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
In-Reply-To: <20010921095721.A725@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have untared SAME linux-2.4.0.tar.gz on two PCs and when I did
make menuconfig in the networking section, only on one of the two machines
there was a choice to use QoS and Fair Queueing.

What is the trick? Or what HW check menuconfig performed before it created
the menu?
Rade

