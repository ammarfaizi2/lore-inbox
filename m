Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317058AbSGHS2H>; Mon, 8 Jul 2002 14:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317059AbSGHS2G>; Mon, 8 Jul 2002 14:28:06 -0400
Received: from fe6.rdc-kc.rr.com ([24.94.163.53]:33807 "EHLO mail6.wi.rr.com")
	by vger.kernel.org with ESMTP id <S317058AbSGHS2E>;
	Mon, 8 Jul 2002 14:28:04 -0400
Message-ID: <002101c226ad$d429c4a0$8a981d41@wi.rr.com>
From: "Ted Kaminski" <mouschi@wi.rr.com>
To: <linux-kernel@vger.kernel.org>
References: <E17RdXQ-0002tr-00@the-village.bc.nu>
Subject: Re: ISAPNP SB16 card with IDE interface
Date: Mon, 8 Jul 2002 13:32:34 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
>
> Is IRQ10 assigned to the ISA bus in your BIOS ?

This system has no options of that sort in its BIOS... (Its a compaq from
about '94 or '95, for reference)

I assume that this means it doesn't care where the IRQs originate. I'm also
pretty sure i've tried setting it up with different IRQs as well. (I will
try again to be certain)

Ted Kaminski

