Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131517AbRAXBDi>; Tue, 23 Jan 2001 20:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131967AbRAXBD2>; Tue, 23 Jan 2001 20:03:28 -0500
Received: from smtp1.jp.psi.net ([154.33.63.111]:40714 "EHLO smtp1.jp.psi.net")
	by vger.kernel.org with ESMTP id <S131517AbRAXBDW>;
	Tue, 23 Jan 2001 20:03:22 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Is this kernel related (signal 11)?
Date: Wed, 24 Jan 2001 09:56:00 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGIENPCNAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGKEMACNAA.rmager@vgkk.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As per Russell King's suggestion, I ran memtest86 on my system for about 12
hours last night. I found no memory errors. Note that the tests did not
complete because I had to stop them this morning. I'll contiue them tonight.
They got through test 9 of 11.


As per David Ford's suggestion, I am looking into upgrading to glibc 2.2.1.
Can someone please give hints on doing this. I tried to upgrade to 2.2 a few
weeks ago and after the 'make install' and then reboot my system was very
broken and I had to reinstall the RedHat glibc RPM from CD to recover. I
found a howto but it seems pretty old. How do other people do this?


I've also done a strace on X. Now what do I do with this 4 MB log file?


Thanks,

--Rainer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
