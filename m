Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282081AbRK1J0r>; Wed, 28 Nov 2001 04:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282099AbRK1J0h>; Wed, 28 Nov 2001 04:26:37 -0500
Received: from [193.78.30.180] ([193.78.30.180]:28242 "EHLO
	rotterdam.jasongeo.com") by vger.kernel.org with ESMTP
	id <S282081AbRK1J0Z>; Wed, 28 Nov 2001 04:26:25 -0500
From: "Wouter van Bommel" <wvanbommel@jasongeo.com>
To: "'szonyi calin'" <caszonyi@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: RE: 'spurious 8259A interrupt: IRQ7'
Date: Wed, 28 Nov 2001 10:31:02 +0100
Message-ID: <002101c177ef$6600ebb0$950000c0@jason.nl>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
In-Reply-To: <20011128085835.40289.qmail@web13105.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also see this messages on various machines each with different hardware.
I see it on 1 cpu Athlon machines, but also on 2 CPU pentium III machines.

- Wouter

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of szonyi calin
> Sent: Wednesday November 28, 2001 9:59 AM
> To: linux-kernel@vger.kernel.org
> Subject: Re: 'spurious 8259A interrupt: IRQ7'
>
>
> Hi
> Cx 486,  no pci, no network card, same message.
> >From my experience in PC hardware i know that irq 7 is
> usually asigned to the parallel port.
> I know a windoze box which didn't print until i set up
> in bios that paralel port has irq7.
>
> Bye
>
> =====
> *********************************************************
>                 Désolé, un problème s'est produit :
>                  *  votre signature ne peut pas comporter
>                  plus de 600 caractères ni occuper plus de
>                  sept lignes.
> Another way to say: Welcome to Yahoo! ^^^
> **********************************************************
>
> __________________________________________________________
> Obtenez votre adresse @yahoo.ca gratuite et en français !
> courriel.yahoo.ca
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

