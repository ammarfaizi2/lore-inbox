Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315429AbSE2TOC>; Wed, 29 May 2002 15:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSE2TOB>; Wed, 29 May 2002 15:14:01 -0400
Received: from h-64-105-136-78.SNVACAID.covad.net ([64.105.136.78]:2738 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315429AbSE2TOB>; Wed, 29 May 2002 15:14:01 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 29 May 2002 12:13:51 -0700
Message-Id: <200205291913.MAA01126@adam.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: business models [was patent stuff]
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
>On Wed, 2002-05-29 at 04:21, Adam J. Richter wrote:
>> 	Example definitions might be: "public domain or any license
>> certified by the Open Software Initiative", "a license that has


>The OSI approves things like the BSD license which is a convenient open
>door for anyone to use such patents in proprietary code with a tiny
>useless BSD licensed library. [...]

	I addressed that previously: you can license just the case
where the entire program is free software.  Patents restrict use, not
just copying.  So, it is hard to argue against the enforceability of
"user does the link" subversion when it comes to patents, which I
infer is your principal objection.


>I would worry much more about the million odd patents IBM have, [...]

	I addressed that previously:

| 	Although other companies today already have many patents that
| | they could argue are infringed by certain free software components.
| The Linux patents are different as a practical matter, however, in
| that the chance of prevailing in that argument will be greater when
| if alleged infringer is using the code for which the patent was
| originally submitted.

[...]
>> If the GPL developers don't shield
>> the Apache developers, the X developers, the BSD developers, and the
>> MPL developers so that their ability to continue with the free software
>> portion of their activities has been respected, do you really think
>> they'll shield GPL development from their patents?

>There is little evidence of that having happened with code,

	Linux distribution vendors make a lot of money from combining
and selling the work of these other free software development
communities.  These other communities currently do a lot of work to
ensure that their software runs under our GPL'ed kernel and LGPL'ed C
library.  The GPL developers are supported in the other direction too:
plenty of GPL'ed software runs under BSD-permission platforms like
tcl, or Apache or on BSD.  Even with the Linux kernel, you have Dave
Hinds relicensing his MPL pcmcia drivers for GPL linking, and sixty
two modules in linux-2.5.18 contain MODULE_LICENSE declarations of
"Dual BSD/GPL", plus two others that are just BSD.

	You would have no Linux distribution if you only shipped
GPL'ed software, or even if the non-GPL free software communities
stopped their continuing substantial efforts to ensure that their
applications run Linux, compile under GCC and binutils, and
interoperate with a host of other GPL'ed components.

	What more should the non-GPL free software communities have
done that now justifies your not licensing your patents for their free
software development?

>its also
>possible to extend lists of licenses, clarify them for specific product
>and so forth.

	If you "extend lists of licenses" _at the outset_, you will
discourage patenting of the non-GPL software you use.  Otherwise, I
think the practice will quickly proliferate if other free software
companies see that their users and contributors tolerate Red Hat
taking out patents on free software implementations and licensing it
GPL-only.  I think subsequent extensions would have less of of a
standards setting effect.


Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
