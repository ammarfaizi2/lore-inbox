Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132147AbRDQMLE>; Tue, 17 Apr 2001 08:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbRDQMKz>; Tue, 17 Apr 2001 08:10:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19982 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132147AbRDQMKg>; Tue, 17 Apr 2001 08:10:36 -0400
Subject: Re: Linux 2.4.3-ac7
To: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 17 Apr 2001 13:11:56 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.05.10104170738380.28549-100000@callisto.of.borg> from "Geert Uytterhoeven" at Apr 17, 2001 07:39:14 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pUKt-0002EA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	| that is intentional - first things first.
> 
> Probably that's why drivers/media/video/Makefile contains references to
> zoran.o, while zoran.c was ditched?

zoran.c moved, because zoran.o is the output name of the module itself
