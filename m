Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132519AbRCZSRx>; Mon, 26 Mar 2001 13:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132522AbRCZSRo>; Mon, 26 Mar 2001 13:17:44 -0500
Received: from isolaweb.it ([213.82.132.2]:25605 "EHLO web.isolaweb.it")
	by vger.kernel.org with ESMTP id <S132519AbRCZSR2>;
	Mon, 26 Mar 2001 13:17:28 -0500
Message-Id: <4.3.2.7.2.20010326201155.00bfa8d0@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 26 Mar 2001 20:13:49 +0200
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: Adaptec Array1000 
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200103261752.f2QHpxs51474@aslan.scsiguy.com>
In-Reply-To: <Your message of "Mon, 26 Mar 2001 19:23:38 +0200." <4.3.2.7.2.20010326191531.00e68220@mail.tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10.51 26/03/01 -0700, Justin T. Gibbs wrote:

> >Hi all,
> >
> >Does anyone know how to configure this controller (chipset AAA-133U2
> >aka AIC-78xx) with one RAID5 hardware volume ? The kernel 2.2.16 see
> >all the disks (4x18Gb) but don't see the unique volume.
>
>These boards are not currently supported in RAID mode.  Your
>best bet is Linux MD.

Ok! As I was thinking, I must configure it with Linux MD.

Thanks.


Roberto Fichera.

