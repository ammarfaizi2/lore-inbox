Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129308AbQKQOcs>; Fri, 17 Nov 2000 09:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129410AbQKQOcj>; Fri, 17 Nov 2000 09:32:39 -0500
Received: from smtp01.oce.nl ([134.188.1.25]:20438 "EHLO smtp01.oce.nl")
	by vger.kernel.org with ESMTP id <S129308AbQKQOc1>;
	Fri, 17 Nov 2000 09:32:27 -0500
>Received: from pc1-adve.oce.nl (pc1-adve.oce.nl [134.188.176.32])
	by smtp02.oce.nl (8.9.3/8.9.3) with ESMTP id PAA09661;
	Fri, 17 Nov 2000 15:00:00 +0100 (MET)
Message-Id: <m13wm3c-000qDCC@pc1-adve.oce.nl>
Date: Fri, 17 Nov 2000 15:00:00 +0100 (CET)
From: adve@oce.nl (Arjan van de Ven)
To: jgarzik@mandrakesoft.com (Jeff Garzik)
CC: linux-kernel@vger.kernel.org
Subject: Re: Error in x86 CPU capabilities starting with test5/6
X-Newsgroups: adve.linux.kernel
In-Reply-To: <E13wkLK-0000bP-00@the-village.bc.nu> <qwwpujuvk1s.fsf@sap.com> <3A152DC1.21B35324@mandrakesoft.com> <qwwlmuivio0.fsf@sap.com> <20001117143150.A6832@gruyere.muc.suse.de> <3A15354B.4736A19@mandrakesoft.com>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre15 (i686))
Content-Type: text
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A15354B.4736A19@mandrakesoft.com> you wrote:
> Andi Kleen wrote:
>> No it would not. Often you want cycle accurate couting for profiling
>> purposes.

> Isn't that why /dev/cpu/%d/msr exists?

This is root only though......

(Yes, you can crash AMD boxes by reading MSR's)

Greetings,
   Arjan van de Ven

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
