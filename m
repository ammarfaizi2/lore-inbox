Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135174AbRDVCbq>; Sat, 21 Apr 2001 22:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135175AbRDVCbg>; Sat, 21 Apr 2001 22:31:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:37249 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135174AbRDVCbW>; Sat, 21 Apr 2001 22:31:22 -0400
Date: Sat, 21 Apr 2001 22:30:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ulrich Drepper <drepper@cygnus.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: Global FPU corruption in 2.2
In-Reply-To: <E14r9Sk-0004ot-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.1010421222656.1848A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Apr 2001, Alan Cox wrote:

> > Only if it traps on the esc op-code --and if it does, we are in a
> > world or hurt for performance. There is no other way that the kernel
> 
> FPU lazy task switch exceptions are a feature of X86 hardware. Have been for
> a very very long time.
> 

Hmmm.. Okay I stand corrected. Guess I haven't checked for a very very
long time.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


