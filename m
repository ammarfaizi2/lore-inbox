Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314463AbSEFPFJ>; Mon, 6 May 2002 11:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314468AbSEFPFI>; Mon, 6 May 2002 11:05:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18451 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314463AbSEFPFH>; Mon, 6 May 2002 11:05:07 -0400
Subject: Re: Linux & X11 & IRQ Interrupts
To: war@starband.net (Justin Piszcz)
Date: Mon, 6 May 2002 16:24:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CD5D57D.DED89DFC@starband.net> from "Justin Piszcz" at May 05, 2002 08:59:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E174kLj-0005Ta-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I move the mouse under X11 I hear a buzzing sound in the computer,
> first, I found it was the console speaker.
> Yet, I still hear a very faint sound when I move the mouse cursor, this
> is after I've disconnected the console speaker, no matter what the rate
> of interrupts.
> Other people have also reported this problem but there hasn't been an
> apparent fix for it yet?

Well you should probably discuss that with your power supply vendor. Linux
makes strong efforts to get the CPU in powered down mode as much as it can


Alan
