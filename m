Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129113AbQJ3M5h>; Mon, 30 Oct 2000 07:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129161AbQJ3M51>; Mon, 30 Oct 2000 07:57:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20545 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129144AbQJ3M5P>; Mon, 30 Oct 2000 07:57:15 -0500
Subject: Re: 2.2.18Pre Lan Performance Rocks!
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Mon, 30 Oct 2000 12:57:45 +0000 (GMT)
Cc: mingo@elte.hu (Ingo Molnar), linux-kernel@vger.kernel.org
In-Reply-To: <20001030025424.A20271@vger.timpanogas.org> from "Jeff V. Merkey" at Oct 30, 2000 02:54:24 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qEVX-0006ql-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> one -- I've got extra licensed copies), install it, put a load of 5000
> connections on it, with 4 adapters.  Dual boot Linux on it, and attempt 
> the same with SAMBA or MARS-NWE, and watch it oink.  

SAMBA and Mars-nwe are running user space thats why. They have flexibility,
protection and can run unpriviledged. If you want to put mars-nwe in the kernel
then it will certainly be interesting

> back and tell me how TUX is going to solve the File and Print performance
> issues in Linux.

There's an http file system around 8)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
