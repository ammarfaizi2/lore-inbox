Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290519AbSBKVm0>; Mon, 11 Feb 2002 16:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290500AbSBKVmQ>; Mon, 11 Feb 2002 16:42:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37124 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290496AbSBKVmG>; Mon, 11 Feb 2002 16:42:06 -0500
Subject: Re: A7M266-D works?
To: gandalf@wlug.westbo.se (Martin Josefsson)
Date: Mon, 11 Feb 2002 21:55:40 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jussi.laako@kolumbus.fi (Jussi Laako),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0202112132040.16582-100000@tux.rsn.bth.se> from "Martin Josefsson" at Feb 11, 2002 09:40:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16aOQG-00082f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you give some examples of which drivers/cards you've seen problems
> with. We've been thinking of getting a few of these boards but if there's
> this much problems with the BIOS we might have to look at another board :(

I2O fails for one. With the little patch I added I2O seems to work again.
Im just waiting a final AMD confirmation that the docs not the bios are
correct.

Alan
