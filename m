Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130445AbQKAVxD>; Wed, 1 Nov 2000 16:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQKAVwx>; Wed, 1 Nov 2000 16:52:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51234 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130309AbQKAVwo>; Wed, 1 Nov 2000 16:52:44 -0500
Subject: Re: binutils/gas problem with 'lcall'
To: mikpe@csd.uu.se (Mikael Pettersson)
Date: Wed, 1 Nov 2000 21:53:56 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200011012144.WAA04414@harpo.it.uu.se> from "Mikael Pettersson" at Nov 01, 2000 10:44:05 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13r5pW-0000tM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> but older binutils like 2.9.5 treat these as syntax errors. Sigh.
> 
> So how do we want to handle this?
> - ignore the warnings? (yuck; I hate compiler/assembler warnings)

Correct ;)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
