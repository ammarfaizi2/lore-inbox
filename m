Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277317AbRKHMeI>; Thu, 8 Nov 2001 07:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278041AbRKHMd6>; Thu, 8 Nov 2001 07:33:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1549 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277317AbRKHMdv>; Thu, 8 Nov 2001 07:33:51 -0500
Subject: Re: Module Licensing?
To: drizzt.dourden@iname.com
Date: Thu, 8 Nov 2001 12:41:01 +0000 (GMT)
Cc: llx@swissonline.ch (LLX), linux-kernel@vger.kernel.org
In-Reply-To: <20011108013625.A3316@menzoberrazan.dhis.org> from "drizzt.dourden@iname.com" at Nov 08, 2001 01:36:25 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161oUQ-0007ZX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (well, I dosn't remember the exact sintax of pointer to funtioncs but .=
> =2E. )
> 
> You can put the binary driver like "microcode", and GPL

Nope. The only cases we have microcode like that in the kernel is downloaded
firmware for devices. The same stuff you'd have been finding in the boot
rom instead 12 months ago before the price squeezes reached ripped out any
flash component and doing software download. Richard Stallman doesn't like
that either, but since he currently runs an OS loaded by and using a binary
only BIOS I don't have any direct sympathies right now
