Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131056AbQK2NnP>; Wed, 29 Nov 2000 08:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131310AbQK2NnF>; Wed, 29 Nov 2000 08:43:05 -0500
Received: from ha1.rdc2.occa.home.com ([24.2.8.66]:49116 "EHLO
        mail.rdc2.occa.home.com") by vger.kernel.org with ESMTP
        id <S131056AbQK2Nmx>; Wed, 29 Nov 2000 08:42:53 -0500
Message-ID: <001501c05a06$2267b760$19211518@vnnys1.ca.home.com>
From: "Android" <android@turbosport.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <E140x2k-0005Ou-00@the-village.bc.nu>
Subject: Re: XFree 4.0.1/NVIDIA 0.9-5/2.4.0-testX/11 woes [solved]
Date: Wed, 29 Nov 2000 05:13:15 -0800
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've never seen such thing as code without bugs. In my experience,
> > the NVIDIA drivers are by far the most complete and solid 3D drivers
> > under Linux.
>
> You are welcome to your opinion. I've got this great bridge to sell you
too

The most stable of all video drivers under Linux has to be the standard VGA
driver.
As for SVGA, then VESA wins that territory. The problem with specific
SVGA/Accelorator
drivers is that the details of the video card operation is kept secret, and
what information
is known is scarce. Much of it is found by experimentation, and dare I say,
reverse engineering.
In most cases, you're lucky you get a working driver at all. The same holds
true for sound cards.
So, unless the company has fully released the details of their NVIDIA card
to whomever wrote
the Linux driver, then don't think for a moment that it is crash-free. Just
one wrong bit sent to
an incorrect port, and it's time to reset your machine. I don't need to
mention data loss.

                                      -- Ted


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
