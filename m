Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131397AbRAKSPD>; Thu, 11 Jan 2001 13:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131249AbRAKSOo>; Thu, 11 Jan 2001 13:14:44 -0500
Received: from cambot.suite224.net ([209.176.64.2]:21253 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S129965AbRAKSOa>;
	Thu, 11 Jan 2001 13:14:30 -0500
Message-ID: <001101c07bfa$daf36ac0$0100a8c0@pittscomp.com>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: "Robert M. Love" <rml@tech9.net>,
        "Giacomo Catenazzi" <cate@student.ethz.ch>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0101111238210.1732-100000@phantasy.awol.org>
Subject: Re: Compile error: DRM without AGP in 2.4.0
Date: Thu, 11 Jan 2001 13:18:08 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert,
> On Thu, 11 Jan 2001, Giacomo Catenazzi spoke:
> > Here a valid configuration (no AGP, but all DRM set)
> > compiling [2.4.0]:
> > [...]
>
> DRM requires AGPGART.

What if your motherboard doesn't have an AGP slot? I'm running an older
Micro Star pentium with a ATI All-in-Wonder with the Rage 128 chipset.

Matthew
mpitts@suite224.net


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
