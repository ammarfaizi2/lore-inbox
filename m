Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288922AbSANTFf>; Mon, 14 Jan 2002 14:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288936AbSANTEj>; Mon, 14 Jan 2002 14:04:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43270 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288946AbSANTC5>; Mon, 14 Jan 2002 14:02:57 -0500
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
To: esr@thyrsus.com
Date: Mon, 14 Jan 2002 19:14:40 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), eli.carter@inet.com (Eli Carter),
        Michael.Lazarou@etl.ericsson.se ("Michael Lazarou (ETL)"),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20020114134426.C17522@thyrsus.com> from "Eric S. Raymond" at Jan 14, 2002 01:44:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QCZ7-0002b4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > it did last week". Random mechanics hating car owners don't do engine tuning
> > jobs or fit turbochargers.
> 
> No...but they do change their own oil and antifreeze.  Upgrading your
> kernel should be as simple as changing your oil.

Yeah. I go to the garage versus I click "up 2 date". I don't mix custom
oils.

> > Secondly we've established we can pick the right CPU for the kernel reliably
> > that is seperate to modules. 
> 
> Right, but that doesn't get you a recompiled binary with extended instructions
> in it.

It does. Once you have picked the required processor type you will get the
right instructions. Except for the Athlon, Winchip and maybe the PIV
I've seen little evidence it matters. The Debian folk claim its worth < 1%
and I don't doubt them.

