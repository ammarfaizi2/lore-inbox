Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132842AbRA3XK2>; Tue, 30 Jan 2001 18:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132946AbRA3XKS>; Tue, 30 Jan 2001 18:10:18 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7552 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132934AbRA3XKG>; Tue, 30 Jan 2001 18:10:06 -0500
Date: Tue, 30 Jan 2001 18:09:48 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Keith Owens <kaos@ocs.com.au>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Version 2.4.1 cannot be built. 
In-Reply-To: <5363.980895893@ocs3.ocs-net>
Message-ID: <Pine.LNX.3.95.1010130180837.4483B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Keith Owens wrote:

> On Tue, 30 Jan 2001 17:57:44 -0500 (EST), 
> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> >On Wed, 31 Jan 2001, Keith Owens wrote:
> >
> >> On Tue, 30 Jan 2001 16:45:16 -0500 (EST), 
> >> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> >> >The subject says it all. `make dep` is now broken.
> >> >make[4]: Entering directory `/usr/src/linux-2.4.1/drivers/acpi'
> >> >Makefile:29: *** target pattern contains no `%'.  Stop.
> >> 
> >> Which version of make are you running?
> >> 
> >	3.74
> >
> >y'a mean even make isn't make anymore?
> 
> You mean that nobody reads Documentation/Changes any more?

Seldom, only once or twice a day. Guess that's not often enough
to keep up on the new tool requirements.

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
