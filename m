Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261834AbREPIuy>; Wed, 16 May 2001 04:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261837AbREPIuo>; Wed, 16 May 2001 04:50:44 -0400
Received: from sanrafael.dti2.net ([195.57.112.5]:18439 "EHLO dti2.net")
	by vger.kernel.org with ESMTP id <S261834AbREPIue>;
	Wed, 16 May 2001 04:50:34 -0400
Message-ID: <008401c0dde5$4234a6d0$061010ac@dti2.net>
From: "Jorge Boncompte [DTI2]" <jorge@dti2.net>
To: "Anuradha Ratnaweera" <anuradha@bee.lk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0105151953150.302-100000@presario>
Subject: Re: 2.4.2 - Locked keyboard
Date: Wed, 16 May 2001 10:50:29 +0200
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

    Yes, I did... I checked NumLock and CapsLock too, but any of this turn
seems to work (the leds doesn't change the state).

 "cat /proc/interrupts" shows that IRQ1 doesn't trigger anymore. Although
all services in the machine are working...(weird, isnt't it?)

    Regards.

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
- Sin pistachos no hay Rock & Roll...
- Without wicker a basket cannot be done.
==============================================================

----- Original Message -----
From: "Anuradha Ratnaweera" <anuradha@bee.lk>
To: "Jorge Boncompte [DTI2]" <jorge@dti2.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, May 15, 2001 3:55 PM
Subject: Re: 2.4.2 - Locked keyboard


>
> On Thu, 10 May 2001, Jorge Boncompte [DTI2] wrote:
>
> > After the reboot, the keyboard was working 5 minutes and then it
> > locked. The console was working. I rebooted the machine again and has
> > been working for 2 days, that the keyboard gets locked again.
>
> Just to make sure...
>
> Did you check scoll lock? :)
>
> Anuradha
>
>
> ----------------------------------------------------------
> <a href="http://www.bee.lk/people/anuradha/">home page</a>
>
>

