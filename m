Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312855AbSDFW5u>; Sat, 6 Apr 2002 17:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312871AbSDFW5t>; Sat, 6 Apr 2002 17:57:49 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:57095
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312855AbSDFW5t> convert rfc822-to-8bit; Sat, 6 Apr 2002 17:57:49 -0500
Date: Sat, 6 Apr 2002 14:56:48 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: =?ISO-8859-1?Q?=C1lvaro_Hern=E1ndez?= Tortosa <aht@telefonica.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to get Soyo's K7V Dragon + smartcard reader working?
In-Reply-To: <1018040202.9939.5.camel@bilbo>
Message-ID: <Pine.LNX.4.10.10204061454270.16046-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You are not permitted to develop SDA readers, without violating patent
issues.  The protocol is psuedo ATA/ATAPI but a mix.  Linux can support
them but legally only via some direct access where application/user-space
does the work.

Regards,

Andre Hedrick
LAD Storage Consulting Group

On 5 Apr 2002, Álvaro Hernández Tortosa wrote:

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
> 
> Thanks in advance,
> 
> Alvaro Hernandez
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

