Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275224AbRJOHDd>; Mon, 15 Oct 2001 03:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275506AbRJOHDX>; Mon, 15 Oct 2001 03:03:23 -0400
Received: from ns.etm.at ([212.88.180.5]:5385 "EHLO etm.at")
	by vger.kernel.org with ESMTP id <S275224AbRJOHDL>;
	Mon, 15 Oct 2001 03:03:11 -0400
Message-Id: <01Oct15.090303cest.117126@fwetm.etm.at>
From: "Stanislav Meduna" <stano@meduna.org>
To: "Kevin Krieser" <kkrieser_list@footballmail.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <NDBBLFLJADKDMBPPNBALAEHFGAAA.kkrieser_list@footballmail.com>
Subject: Re: USB stability - possibly printer related
Date: Mon, 15 Oct 2001 09:02:30 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Msmail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-Mimeole: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


> I know I've attempted to use the same IBM hard drive on the HPT366
> controller with little success.  I got hangups until I moved it back to the
> secondary IDE controller.

There was a BIOS update targeting problems with the newer IBM drives
on the 366 - what HPT BIOS did give you problems?

> One thing I have noticed is that, with the 2.4 kernels, my system doesn't
> like sharing IRQs as well as the 2.2 kernels. So you may want to see what
> devices share interrupts with your USB controller, and move the cards if
> necessary.

Thanks for a tip - I'll try it. Hopefully the two are not USB and HPT :-S

Regards
-- 
                                                          Stano


