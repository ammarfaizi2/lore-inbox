Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288830AbSBMUJp>; Wed, 13 Feb 2002 15:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288855AbSBMUJf>; Wed, 13 Feb 2002 15:09:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18700 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288830AbSBMUJ0>; Wed, 13 Feb 2002 15:09:26 -0500
Subject: Re: Kernel 2.2.20 RAM requirements
To: pitt@gmx.at (Christoph Pittracher)
Date: Wed, 13 Feb 2002 20:23:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200202131947.40915@pitt4u.2y.net> from "Christoph Pittracher" at Feb 13, 2002 07:57:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16b5w1-0006Js-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wanted to boot kernel version 2.2.20 on my old Pentium 75Mhz system 
> with 16MB RAM. After "uncompressing linux" i get a: "Out Of Memory -- 
> System halted".
> Kernel version 2.2.19 works without problems (same kernel 
> configuration). I didn't tried 2.4 kernels yet, but I wonder that 
> 2.2.20 needs so much memory?

It doesn't. What boot loader are you using ?
