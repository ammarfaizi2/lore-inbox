Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136196AbRARXZt>; Thu, 18 Jan 2001 18:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136213AbRARXZl>; Thu, 18 Jan 2001 18:25:41 -0500
Received: from zeus.kernel.org ([209.10.41.242]:57035 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136229AbRARXZV>;
	Thu, 18 Jan 2001 18:25:21 -0500
Message-ID: <001a01c081a2$2da1d700$067039c3@cintasverdes>
From: "Jorge Boncompte \(DTI2\)" <jorge@dti2.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <001c01c08199$387205f0$067039c3@cintasverdes> <20010118161000.A3487@mediaone.net> <20010118224205Z135934-403+1634@vger.kernel.org>
Subject: RE: ERR in /proc/interrupts
Date: Thu, 18 Jan 2001 23:58:31 +0100
Organization: DTI2 - Desarrollo de la Tecnología de las Comunicaciones
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Timur,

     This isn't a SMP system. I have no plans to upgrade this box to SMP
unless AMD has a processor ready for it ;-)

    Kernel 2.4.0test12 + reiserfs 3.6.23
    Tyan K7 mobo
    AMD Athlon 800 (kernel built for AMD Athlon no SMP)
    d-link 530tx (via-rhine module)
    d-link 550tx (sundance module)
    cmd-649 ide controller (cmd driver)

     -Jorge

==============================================================
Jorge Boncompte - Técnico de sistemas
DTI2 - Desarrollo de la Tecnología de las Comunicaciones
--------------------------------------------------------------
C/ Abogado Enriquez Barrios, 5   14004 CORDOBA (SPAIN)
Tlf: +34 957 761395 / FAX: +34 957 450380
--------------------------------------------------------------
jorge@dti2.net _-_-_-_-_-_-_-_-_-_-_-_-_-_ http://www.dti2.net
==============================================================
Without wicker a basket cannot be done.
==============================================================

----- Mensaje original -----
De: "Timur Tabi" <ttabi@interactivesi.com>
Para: <linux-kernel@vger.kernel.org>
Enviado: jueves, 18 de enero de 2001 23:41
Asunto: Re: ERR in /proc/interrupts


> ** Reply to message from "Jorge Boncompte \(DTI2\)" <jorge@dti2.net> on
Thu, 18
> Jan 2001 23:31:38 +0100
>
>
> > Are IPI related to SMP machines? This is not an SMP machine nor kernel.
>
> Yes, Inter-Process Interrupts are an SMP thing.  I know you need to have
an SMP
> kernel for IPI's to be issued, but I don't know if you actually need to
have
> more than one processor.
>
> Obviously, someone here is confused.  I just hope it's not me!
>
>
> --
> Timur Tabi - ttabi@interactivesi.com
> Interactive Silicon - http://www.interactivesi.com
>
> When replying to a mailing-list message, please direct the reply to the
mailing list only.  Don't send another copy to me.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
