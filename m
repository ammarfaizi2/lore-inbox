Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271769AbRH0P7g>; Mon, 27 Aug 2001 11:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271767AbRH0P73>; Mon, 27 Aug 2001 11:59:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6663 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271765AbRH0P7T>; Mon, 27 Aug 2001 11:59:19 -0400
Subject: Re: 2.2.19 boot failure
To: hoefkens@msu.edu (Jens Hoefkens)
Date: Mon, 27 Aug 2001 17:02:46 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0108271157230.8066-100000@dvorak> from "Jens Hoefkens" at Aug 27, 2001 12:09:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15bOqc-0004CB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a M54Pe-12M dual Pentium board with 2xP100. The machine boots
> fine with a single CPU kernel (dmesg output [1] and kernel config [2]
> below), but fails to boot with SMP kernels (config below [3]).
> 
> All I get is the message "Uncompressing Linux... OK, booting the
> kernel" and then the system hangs (the keyboard is completely dead, no
> numlock, caps lock, or Ctrl-Alt-Del). And to be sure, I have run LILO
> after installing the new kernel.

Can you boot it with a serial console ?
