Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129234AbQKTRHU>; Mon, 20 Nov 2000 12:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQKTRHK>; Mon, 20 Nov 2000 12:07:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16178 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129234AbQKTRGx>; Mon, 20 Nov 2000 12:06:53 -0500
Subject: Re: 2.2.16 does not compile
To: andrei@ds5500.cemr.wvu.edu (Andrei Smirnov)
Date: Mon, 20 Nov 2000 16:37:25 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.ULT.3.96.1001120110905.28412A-100000@ds5500> from "Andrei Smirnov" at Nov 20, 2000 11:30:21 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13xtwd-0003ng-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a newly installed RH-7.0 distribution on a Celeron Pentium 400.
> When I tried to compile the kernel I got the following:
> 
> 1. I ran make xconfig (or make menuconfig) and saved without changing any
>    options - completed OK

Step 0: make mrproper
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
