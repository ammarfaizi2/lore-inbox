Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbVLFCY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbVLFCY0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbVLFCYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:24:25 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:12753 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S964929AbVLFCYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:24:24 -0500
Message-Id: <200512060041.jB60fElI003764@pincoya.inf.utfsm.cl>
To: Bernd Petrovitsch <bernd@firmix.at>
cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel 
In-Reply-To: Message from Bernd Petrovitsch <bernd@firmix.at> 
   of "Mon, 05 Dec 2005 10:06:07 BST." <1133773567.22753.15.camel@tara.firmix.at> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Mon, 05 Dec 2005 21:41:14 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch <bernd@firmix.at> wrote:
> [ Minimized quoted part ]
> On Sun, 2005-12-04 at 17:43 -0700, Jeff V. Merkey wrote:
> > Bernd Petrovitsch wrote:
> > >On Sat, 2005-12-03 at 17:52 -0700, Jeff V. Merkey wrote:
> [...]
> > >>of this code. I have apps written for Windows in 1990 and 1998 that 
> > >                      ^^^^
> > >>still run on Windows XP today. Linux has no such concept of

> > >But this not even holds for nearly all apps.

> > >>backwards compatiblity. Every company who has embraced it outside of 

> > >The same holds (probably) for Linux apps (given that your kernel can
> > >start a.out). And AFAIBT by Win* driver developers even in the Win*
> > >world you have to change your driver because of a new Win* version now
> > >and then.
> [...]
> > whole libc -> glib switchover.

> glib has AFAIK next to nothing to do with a libc AFAICT (i.e. it is
> using standard libc functions but that's all).

He refers to the a.out to ELF switchover. Yes, it was painful. But not as
much as he makes out. The Win98 --> WinNT change was worse, IMHO.

> > It's hilarious that BSD had to create a Linux app compat lib,

And Solaris forever had a BSD compatibility suite, including libraries and
tools. So what?

> >                                                               and the 
> > RedHat shipped compat libs for 3 releases

So legacy stuff continued working. And that is bad how?

> Here you have your backwards compatibility.

Right.

> > as well.   Not even close.  Windows has won.  M$ has won.  Linux lost 
> > the desktop wars

First of all, Linux isn't about "winning a war". And the desktop wars
haven't really started...

> >                  and will soon loose the server wars as well.

Sorry, but that one is almost over, and Linux has won.

> >                                                                 The
> > reason - infighting and lack of backwards 

> Yes, probably - MSFT is spreading the same story since ages.

Gandhi-con 3 ;-)

> >                                           compatibility.  Binary only
> > module breakage kernel to kernel will continue. 

So what? Binary modules are mostly bad and break the kernel, so...

> As other told there never was a stable kernel module interface. Of
> course there is probably enough willing manpower out there who will work
> on that once you pay them. Or you can provide such support on your own.

Right.

> Or do you (or anybody else) has drivers which should be maintained for
> vanilla-kernel and/or vendor kernels and/or other kernels (to fix the
> breakage in a cosntructive way), we can provide you with an offer to do
> that.

Constructive criticism? Even of the sort that contributes something? What
are you thinking about?!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

