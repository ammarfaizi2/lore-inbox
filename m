Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276984AbRJDU1U>; Thu, 4 Oct 2001 16:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277129AbRJDU1K>; Thu, 4 Oct 2001 16:27:10 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17679 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276984AbRJDU06>; Thu, 4 Oct 2001 16:26:58 -0400
Subject: Re: i845 anybody?
To: igor.mozetic@uni-mb.si (Igor Mozetic)
Date: Thu, 4 Oct 2001 21:32:42 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15292.5448.370039.388516@cmb1-3.dial-up.arnes.si> from "Igor Mozetic" at Oct 04, 2001 09:52:40 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pFAg-00040g-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Has anybody had any success/problems with i845 based mobo?
> Low-end Pentium IV + a lot of SDRAM seems a good deal at the moment.

i845 doesnt have DDR support, so if you want high memory bandwidth you
might want to look elsewhere.

> Alternatively, I was considering Athlon + VIA 133A, but I have
> noticed a number of reported problems on this list.
> Any comments/suggestions appreciated.

I think its fair to say we understand the VIA chipset problems, then IDE
stuff is dealt with. The athlon optimsation problem is also something with
a known cure.

Alan
