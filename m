Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310487AbSCPRsx>; Sat, 16 Mar 2002 12:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310488AbSCPRso>; Sat, 16 Mar 2002 12:48:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17929 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310487AbSCPRs1>; Sat, 16 Mar 2002 12:48:27 -0500
Subject: Re: [PATCH] Re: 2.5.7-pre2 -- kernel.o(.data+0x300): undefined
To: viro@math.psu.edu (Alexander Viro)
Date: Sat, 16 Mar 2002 18:01:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <Pine.GSO.4.21.0203161236200.5891-100000@weyl.math.psu.edu> from "Alexander Viro" at Mar 16, 2002 12:39:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mIUK-0006qJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is what Linus threw out before - when David wanted to use it to remove
> > all the intermodule crap.
> > 
> > It doesn't work with some architecture binutils
> 
> Erm...  In this case we are within statatically linked image.  In which
> situations it doesn't work?  AFAICS it's as straightforward use of weak
> aliases as it gets...

Grepping I don't have the original mails on the subject
