Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313367AbSDFA5e>; Fri, 5 Apr 2002 19:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313827AbSDFA5Y>; Fri, 5 Apr 2002 19:57:24 -0500
Received: from ip68-7-112-74.sd.sd.cox.net ([68.7.112.74]:16655 "EHLO
	clpanic.kennet.coplanar.net") by vger.kernel.org with ESMTP
	id <S313367AbSDFA5P>; Fri, 5 Apr 2002 19:57:15 -0500
Message-ID: <001d01c1dd05$f8a36f80$7e0aa8c0@bridge>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: =?iso-8859-1?Q?=C1lvaro_Hern=E1ndez_Tortosa?= <aht@telefonica.net>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1018040202.9939.5.camel@bilbo>
Subject: Re: How to get Soyo's K7V Dragon + smartcard reader working?
Date: Fri, 5 Apr 2002 16:56:58 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See the MUSCLE project at www.linuxnet.com.

The K7V uses the ITE8705F, which does not appear to
be currently supported.

The datasheets and programming guides are freely available for
download from www.iteusa.com.

----- Original Message -----
From: "Álvaro Hernández Tortosa" <aht@telefonica.net>
Sent: Friday, April 05, 2002 1:13 PM

> I've ran through a lot of search trying to find out how to get it
> working. As you may already know, this smartcard reader comes
> 'out-of-the-box' with this socket A motherboard.
>
> As long as it comes with a special cable which connects it directly to
> the motherboard, i'm not sure which kind of interface (e.g., is it pci,
> serial interface?) do i have to configure, or even if it has kernel
> support.
>
> Anyone can point me to some useful documentation, resources or whatever?
> If there's no kernel support but technical docs, i'll consider to start
> developping that device driver.

