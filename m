Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269412AbRHCPla>; Fri, 3 Aug 2001 11:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269417AbRHCPlU>; Fri, 3 Aug 2001 11:41:20 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:45836 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S269412AbRHCPlJ>; Fri, 3 Aug 2001 11:41:09 -0400
Message-ID: <01ca01c11c33$247cc0f0$bef7020a@mammon>
From: "Jeremy Linton" <jlinton@interactivesi.com>
To: "Szabolcs Szakacsits" <szaka@f-secure.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0108030400180.5800-100000@fs131-224.f-secure.com>
Subject: Re: Ongoing 2.4 VM suckage pagemap_lru_lock
Date: Fri, 3 Aug 2001 10:44:06 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I have 2.4.4 as well as 2.4.7pre6 on the box. That stack dump was
generated from a 2.4.4 kernel.



----- Original Message -----
From: "Szabolcs Szakacsits" <szaka@f-secure.com>
To: "Jeremy Linton" <jlinton@interactivesi.com>
Sent: Thursday, August 02, 2001 8:01 PM
Subject: Re: Ongoing 2.4 VM suckage pagemap_lru_lock


>
> On Thu, 2 Aug 2001, Jeremy Linton wrote:
>
> > #0  reclaim_page (zone=0xc0285ae8) at
> > /usr/src/linux.2.4.4/include/asm/spinlock.h:102
>
> Are you using 2.4.4? This is an old issue, the relevant codes changed
> significantly ....
>
> Szaka
>
>


