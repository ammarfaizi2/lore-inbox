Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287848AbSANR6M>; Mon, 14 Jan 2002 12:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287863AbSANR56>; Mon, 14 Jan 2002 12:57:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47365 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287848AbSANR4r>; Mon, 14 Jan 2002 12:56:47 -0500
Subject: Re: ISA hardware discovery -- the elegant solution
To: babydr@baby-dragons.com (Mr. James W. Laferriere)
Date: Mon, 14 Jan 2002 18:08:32 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), esr@thyrsus.com,
        cate@debian.org (Giacomo Catenazzi),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <Pine.LNX.4.44.0201141254001.3238-100000@filesrv1.baby-dragons.com> from "Mr. James W. Laferriere" at Jan 14, 2002 12:55:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QBX6-0002Op-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Hello All ,  And what mechanism is going to be used for an -all-
> 	compiled in kernel ?  Everyone and there brother is so enamoured
> 	of Modules .  Not everyone uses nor will use modules .

For 2.5 if things go to plan there will be no such thing as a "compiled in"
driver. They simply are not needed with initramfs holding what were once the
"compiled in" modules.

Alan

