Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264759AbRFXVYG>; Sun, 24 Jun 2001 17:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264760AbRFXVXq>; Sun, 24 Jun 2001 17:23:46 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:61610 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S264759AbRFXVXh>; Sun, 24 Jun 2001 17:23:37 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200106242122.XAA14175@sunrise.pg.gda.pl>
Subject: Re: Some experience of linux on a Laptop
To: android@abac.com (Android)
Date: Sun, 24 Jun 2001 23:22:49 +0200 (MET DST)
Cc: pzycrow@hotmail.com (John Nilsson), linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20010624141432.00a52f38@mail.abac.com> from "Android" at Jun 24, 2001 02:22:04 PM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Features I would like in the kernel:
> >1: Make the whole insmod-rmmod tingie a kernel internal so they could be 
> >trigged before rootmount.
> 
> How can you load modules into the kernel before root is mounted?
> No harddrive accessible means no modules.

initrd ?
It's quite popular feature at present.

Andrzej

