Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271935AbRIVSzA>; Sat, 22 Sep 2001 14:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271978AbRIVSyv>; Sat, 22 Sep 2001 14:54:51 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28173 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271935AbRIVSyh>; Sat, 22 Sep 2001 14:54:37 -0400
Subject: Re: Re[03]: Linux Kernel 2.2.20-pre10 Initial Impressions
To: jlmales@softhome.net
Date: Sat, 22 Sep 2001 20:00:06 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3BAC8E1C.2201.524EE2@localhost> from "John L. Males" at Sep 22, 2001 01:11:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ks0U-0003xB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Understood, but I actually took my 2.2.19 .config and ran "make
> oldconfig", then "make xconfig" making no changes, just saved it

Excellent. That makes the data so much more valuable

> I am likely to do the benchmark tonight to get hard numbers on the
> difference I sense.  I am a QA/Testing Specialist, so I am all to
> aware of the importance of keeping the variables all the same.  My
> initial background was with assembler back in the real core
> memory/keypunch days where I disassembled and heavily modified the
> OS, compiler, assembler, system utilities and wrote a new way to load
> the OS, compilers, etc from scratch to a new disk.  Ony advising you
> so you have a sense of my mindset and level of understanding.  Not
> current with intimate x86 details or assembler, but will someday now
> that "falt" memory is back! :))
> 
> I will let you know what I find.  If in meantime you feel there are
> other things needed or for me to check please let me know and I will
> be most happy to assist.

I look forward to the results. Can you cc Andrea Arcangeli on them if they
look VM related as Andrea is the 2.2.19 VM person (and now the 2.4.10pre
one)
