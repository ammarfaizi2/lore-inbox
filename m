Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273877AbRJIJcE>; Tue, 9 Oct 2001 05:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273883AbRJIJby>; Tue, 9 Oct 2001 05:31:54 -0400
Received: from law2-oe37.hotmail.com ([216.32.180.30]:35845 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S273877AbRJIJbv>;
	Tue, 9 Oct 2001 05:31:51 -0400
X-Originating-IP: [213.82.66.51]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Athlon kernel crash (i686 works)
Date: Tue, 9 Oct 2001 11:32:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <LAW2-OE3760Ov0Hvk1w000079df@hotmail.com>
X-OriginalArrivalTime: 09 Oct 2001 09:32:16.0731 (UTC) FILETIME=[48FADAB0:01C150A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I updated my motherboard from ASUS A7V to ABIT KT7A (VIA Apollo KT133A
chipset). The kernel I had (2.4.10) started crashing on boot  usually
right after starting init. I tryed a i686 kernel and noticed it works
OK, so I recompiled my crashy kernel only switching the processor type
and it also worked. Changed it back to Athlon/K7/Duron and it starts
crashing.

I also search the mailing list. My mother board is KT7A series v1.3 with
bios revision 4T (I also try with 3N, same results). K7 at 1333MHz. BIOS
settings are default (except I have disabled all BIOS/video shadow).
After flash I also reset CMOS via hardware jumper.

Is there any solution to this (except compiling kernel for 6x86)?

TIA
