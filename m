Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280805AbRLBQZI>; Sun, 2 Dec 2001 11:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280814AbRLBQY6>; Sun, 2 Dec 2001 11:24:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19217 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280805AbRLBQYx>; Sun, 2 Dec 2001 11:24:53 -0500
Subject: Re: Coding style - a non-issue
To: khyron@khyron.com (Khyron)
Date: Sun, 2 Dec 2001 16:33:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (LKML - Linux Kernel Mailing List)
In-Reply-To: <Pine.BSF.4.33.0112020626460.94365-100000@four.malevolentminds.com> from "Khyron" at Dec 02, 2001 06:34:17 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16AZYd-0003nZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Bad combination of USB and devfs was able to do this in half
> an hour, and this was *VENDOR KERNEL* that did hopefully get
> more testing than that what is released to the general public.
> I surely cannot recommend using 2.4 to our customers."

So change vendor. There are reasons Red Hat for example does not ship devfs.
It's never been good enough to pass inspection let alone coverage or stress
testing it.
