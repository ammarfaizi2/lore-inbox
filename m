Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132772AbRA3W62>; Tue, 30 Jan 2001 17:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132893AbRA3W6S>; Tue, 30 Jan 2001 17:58:18 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4480 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132772AbRA3W6J>; Tue, 30 Jan 2001 17:58:09 -0500
Date: Tue, 30 Jan 2001 17:57:44 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Keith Owens <kaos@ocs.com.au>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Version 2.4.1 cannot be built. 
In-Reply-To: <4697.980894182@ocs3.ocs-net>
Message-ID: <Pine.LNX.3.95.1010130175517.3672A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Keith Owens wrote:

> On Tue, 30 Jan 2001 16:45:16 -0500 (EST), 
> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> >The subject says it all. `make dep` is now broken.
> >make[4]: Entering directory `/usr/src/linux-2.4.1/drivers/acpi'
> >Makefile:29: *** target pattern contains no `%'.  Stop.
> 
> Which version of make are you running?
> 
	3.74


y'a mean even make isn't make anymore?
Temporary 'fix' was `make -i` for the dependencies. All files I
need built okay.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
