Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132513AbRCZRzN>; Mon, 26 Mar 2001 12:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132522AbRCZRy6>; Mon, 26 Mar 2001 12:54:58 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:46344 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132518AbRCZRxI>; Mon, 26 Mar 2001 12:53:08 -0500
Message-Id: <200103261752.f2QHpxs51474@aslan.scsiguy.com>
To: Roberto Fichera <kernel@tekno-soft.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec Array1000 
In-Reply-To: Your message of "Mon, 26 Mar 2001 19:23:38 +0200."
             <4.3.2.7.2.20010326191531.00e68220@mail.tekno-soft.it> 
Date: Mon, 26 Mar 2001 10:51:59 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi all,
>
>Does anyone know how to configure this controller (chipset AAA-133U2
>aka AIC-78xx) with one RAID5 hardware volume ? The kernel 2.2.16 see
>all the disks (4x18Gb) but don't see the unique volume.

These boards are not currently supported in RAID mode.  Your
best bet is Linux MD.

--
Justin
