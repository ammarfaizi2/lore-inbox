Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKVLKN>; Wed, 22 Nov 2000 06:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129777AbQKVLKE>; Wed, 22 Nov 2000 06:10:04 -0500
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:56075 "EHLO nyc.rr.com")
	by vger.kernel.org with ESMTP id <S129091AbQKVLJu>;
	Wed, 22 Nov 2000 06:09:50 -0500
Message-ID: <013001c05470$717d95e0$0ac809c0@hotmail.com>
From: "Anthony Barbachan" <barbacha@Hinako.AMBusiness.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Fw: Error in 2.2.14 and 2.2.15: kmem_alloc: Bad slab magic (corrupt) (name=buffer_head)
Date: Wed, 22 Nov 2000 05:39:07 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

    I've gotten a few emails like the one below since my original post about
seeing the bad slab magic corruption on a Linux server which I had been
running.  From the emails I've gotten this error now spans hardware.  Mine
was an Athlon.  This guy is a K6-2.  The only thing I am not sure of is if
one of those emails mentioned an Intel.  Could something be going on here?

----- Original Message -----
From: "Chris Sparks" <mrada@catalina-inter.net>
To: <barbacha@Hinako.AMBusiness.com>
Sent: Monday, November 20, 2000 9:03 AM
Subject: Re: Error in 2.2.14 and 2.2.15: kmem_alloc: Bad slab magic
(corrupt) (name=buffer_head)


> Hi Anthony,
>
> Back in May of this year you responded to a "Bad slab magic" problem
> with Linux.  Did you ever come to a resolution as to what was causing
> the error?  I am getting this error with RedHat 7.0 AMD K6-2 400 MHZ
> system.
>
> --
> Chris Sparks
>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
