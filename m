Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129355AbRCEPpR>; Mon, 5 Mar 2001 10:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129359AbRCEPpH>; Mon, 5 Mar 2001 10:45:07 -0500
Received: from mail.valinux.com ([198.186.202.175]:21772 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129355AbRCEPo5>;
	Mon, 5 Mar 2001 10:44:57 -0500
To: pazke@orbita.don.sitek.net
CC: linux-kernel@vger.kernel.org
In-Reply-To: <20010305153704.A20753@debian> (message from Andrey Panin on Mon,
	5 Mar 2001 15:37:04 +0300)
Subject: Re: [PATCH] /drivers/char/serial.c cleanup
From: tytso@valinux.com
Phone: (781) 391-3464
In-Reply-To: <20010305153704.A20753@debian>
Message-Id: <E14ZxAH-0002M9-00@beefcake.hdqt.valinux.com>
Date: Mon, 05 Mar 2001 07:44:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Mon, 5 Mar 2001 15:37:04 +0300
   From: Andrey Panin <pazke@orbita.don.sitek.net>

   I already sent this patch some days ago, but didn't get an answer :(
   So, i'm trying to resubmit it.

Thanks for submitting it; the general idea of the patch looks good, but
as prumpf pointed out, the test for ioremap is reversed, so it looks 
like it hasn't been tested.

I'll fix it up and send it on to Linus.

							- Ted
