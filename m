Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277258AbRKMRPX>; Tue, 13 Nov 2001 12:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277165AbRKMRPE>; Tue, 13 Nov 2001 12:15:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45066 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277112AbRKMRO4>; Tue, 13 Nov 2001 12:14:56 -0500
Subject: Re: Merge BUG in 2.4.15-pre4 serial.c
To: dalecki@evision.ag
Date: Tue, 13 Nov 2001 17:11:22 +0000 (GMT)
Cc: rmk@arm.linux.org.uk (Russell King), alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3BF15A72.793A1BF2@evision-ventures.com> from "Martin Dalecki" at Nov 13, 2001 06:37:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163h5m-0001kJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well I still think that the 8 lines can be deleted. Once again my famous
> notbook is perfectly __i386__ and doesn't contain any devices served by
> serial.c
> unless I configure IrDA. Pushing the port numbers artificially behind
> doesn't make sense for me and makes some setserial unknown tricks
> neccessary

Renumbering everyones serial ports by suprise seems to be a 2.5 thing
