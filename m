Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292666AbSBURjq>; Thu, 21 Feb 2002 12:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292669AbSBURji>; Thu, 21 Feb 2002 12:39:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49415 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292666AbSBURiP>; Thu, 21 Feb 2002 12:38:15 -0500
Subject: Re: [PATCH] 2.5.5 IDE cleanup 11
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Thu, 21 Feb 2002 17:52:08 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3C752E1D.20606@evision-ventures.com> from "Martin Dalecki" at Feb 21, 2002 06:27:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dxO4-0007f6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I hadn't tought about it I wouldn't be that advantegrous.
> And my testing of it did consist of the following:
> 
> 1. 2 x IDE drives of one IDE port.
> 2. 1 x CD-RW on a second port - modularized.
> 3. 1 x CarBus to CF adapter.

So you didnt test or consider the upcoming things like hotplug. 

I'm sure the cleanup works now, but imagine if I was to "clean up" Jens
new block code by removing all the stuff he has there ready for next
features.
