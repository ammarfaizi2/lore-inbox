Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268233AbRGZQHZ>; Thu, 26 Jul 2001 12:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268231AbRGZQHP>; Thu, 26 Jul 2001 12:07:15 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38670 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268223AbRGZQHE>; Thu, 26 Jul 2001 12:07:04 -0400
Subject: Re: Linux 2.4.7-ac1
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Thu, 26 Jul 2001 17:08:16 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0107261128340.3955-100000@freak.distro.conectiva> from "Marcelo Tosatti" at Jul 26, 2001 11:29:50 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PngP-00041F-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe  -march=i386 -DMODULE -DMODVERSIONS
> -include
> /home/marcelo/rpm/BUILD/kernel-2.4.7/linux/include/linux/modversions.h -c
> -o scsi.o scsi.c
> scsi.c: In function `scsi_reset_provider_Rsmp_b879693c':
> scsi.c:2729: structure has no member named `sem'

There is no line 2729 in scsi.c
