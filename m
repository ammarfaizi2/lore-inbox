Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbRCPPmL>; Fri, 16 Mar 2001 10:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130565AbRCPPmB>; Fri, 16 Mar 2001 10:42:01 -0500
Received: from [142.176.139.106] ([142.176.139.106]:3846 "EHLO ve1drg.com")
	by vger.kernel.org with ESMTP id <S130552AbRCPPlw>;
	Fri, 16 Mar 2001 10:41:52 -0500
Date: Fri, 16 Mar 2001 11:40:42 -0400 (AST)
From: Ted Gervais <ve1drg@ve1drg.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.2-ac20
Message-ID: <Pine.LNX.4.21.0103161138110.5008-100000@ve1drg.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wondering something about this new installation - kernel 2.4.2-ac20.

I am running soundmodem as a module and when I run 'insmod soundmodem' I
see this:

unix:/etc# insmod soundmodem
Using /lib/modules/2.4.2-ac20/kernel/drivers/net/hamradio/soundmodem/soundmodem.o
/lib/modules/2.4.2-ac20/kernel/drivers/net/hamradio/soundmodem/soundmodem.o: unresolved symbol hdlcdrv_transmitter_Rccccc7c3
/lib/modules/2.4.2-ac20/kernel/drivers/net/hamradio/soundmodem/soundmodem.o: unresolved symbol hdlcdrv_register_hdlcdrv_R5cc2770d
/lib/modules/2.4.2-ac20/kernel/drivers/net/hamradio/soundmodem/soundmodem.o: unresolved symbol hdlcdrv_arbitrate_R6954b1ce
/lib/modules/2.4.2-ac20/kernel/drivers/net/hamradio/soundmodem/soundmodem.o: unresolved symbol hdlcdrv_unregister_hdlcdrv_R2d89fb74
/lib/modules/2.4.2-ac20/kernel/drivers/net/hamradio/soundmodem/soundmodem.o: unresolved symbol hdlcdrv_receiver_Rde0ac756

Anyone have any thoughts on this?  Why the unresolved symbols??
 
---
Earth is a beta site. 
                
Ted Gervais <ve1drg@ve1drg.com>
44.135.34.201 linux.ve1drg.ampr.org


