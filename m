Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129751AbRBGBuH>; Tue, 6 Feb 2001 20:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129850AbRBGBtr>; Tue, 6 Feb 2001 20:49:47 -0500
Received: from scout.phpwebhosting.com ([64.29.16.128]:27396 "HELO
	scout.phpwebhosting.com") by vger.kernel.org with SMTP
	id <S129751AbRBGBtk>; Tue, 6 Feb 2001 20:49:40 -0500
Message-Id: <4.2.2.20010206194415.00b2bb60@mail.heptasphere.com>
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.2.2 
Date: Tue, 06 Feb 2001 19:45:19 -0600
To: linux-kernel@vger.kernel.org
From: Ben Pharr <ben-kernel@heptasphere.com>
Subject: Re: FA-311 / Natsemi problems with 2.4.1
In-Reply-To: <3A8088B1.7E4B4604@mandrakesoft.com>
In-Reply-To: <3A806A22.4020204@netgem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:28 PM 2/6/01 , you wrote:
>Jocelyn Mayer wrote:
> >
> > I found something from OpenBSD:
> > the natsemi chip (in fact DP83815)
> > is quite the same as SiS900 one.
>
>If that is true, maybe you can hack drivers/net/sis900.c to get it to
>work with the FA-311?
>
>         Jeff


My FA311 works fine with the natsemi driver.

Ben Pharr
bnpharr@olemiss.edu
-------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
