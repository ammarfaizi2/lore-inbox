Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135699AbREFSRV>; Sun, 6 May 2001 14:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135802AbREFSRL>; Sun, 6 May 2001 14:17:11 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:50530 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S135699AbREFSRE>; Sun, 6 May 2001 14:17:04 -0400
Message-ID: <000b01c0d658$a19163a0$3303a8c0@pnetz>
From: =?iso-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: "Jussi Laako" <jlaako@pp.htv.fi>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200105051626.SAA16651@cave.bitwizard.nl> <3AF4824F.8964E53B@home.com> <3AF57F63.9900089E@pp.htv.fi>
Subject: Re: Athlon possible fixes
Date: Sun, 6 May 2001 20:16:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, I'm wondering if this could be same bug that I'm seeing with ASUS
> A7V133 & Duron/800 when using IDE autotuning (PDC20265).
> Still haven't got any replies suggesting any reason for lockups I'm seeing
> (no oopses). Or is the Promise driver just buggy, because system is solid
> with noautotune. RAID5 (md) on that server is just little bit sluggish
with

OK. I tried it on my A7V133 system and leaving out autotune (just for
Promise, where I connected the hard discs)  makes the system stable.  I
thought my problem is related to the Athlon compile problem I read in this
group, but now I am not sure.
Can you try and mail me if the Kernel 2.4.3 (without any ac patch) is stable
with your system even if you use autotune? "Downgrade" to this kernel works
fine for me.

greetings
Christian Bornträger


