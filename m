Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbRFKQgQ>; Mon, 11 Jun 2001 12:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261979AbRFKQgH>; Mon, 11 Jun 2001 12:36:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48146 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261861AbRFKQf6>; Mon, 11 Jun 2001 12:35:58 -0400
Subject: Re: [CHECKER] 15 probable security holes in 2.4.5-ac8
To: jcwren@jcwren.com
Date: Mon, 11 Jun 2001 17:34:12 +0100 (BST)
Cc: jreuter@suse.de (Joerg Reuter), linux-kernel@vger.kernel.org
In-Reply-To: <NDBBKBJHGFJMEMHPOPEGEECLCJAA.jcwren@jcwren.com> from "John Chris Wren" at Jun 11, 2001 10:09:46 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E159Udo-0008RP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What someone *really* needs to do is design a Z8530 adapter with a USB
> interface.  The amateur radio community (well, the 56K'ers, at any rate),
> would love such a device.  The PI2 card is a flakey beast, at best.

You would be much better off attaching a straight ADC/DAC at say up to 
256Kbits/8bit sampling and some control lines to the USB. That would also
let people dumb the ridiculous 1960's technology they insist on using and
run serious stuff like adaptive encoders, golay codecs and the like and
bring amateur packet radio out of the stone age

Alan

