Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264528AbTLEWoC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 17:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264548AbTLEWoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 17:44:02 -0500
Received: from web11502.mail.yahoo.com ([216.136.172.47]:10582 "HELO
	web11502.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264528AbTLEWnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 17:43:46 -0500
Message-ID: <20031205224345.13710.qmail@web11502.mail.yahoo.com>
Date: Fri, 5 Dec 2003 14:43:45 -0800 (PST)
From: gary ng <garyng2000@yahoo.com>
Subject: Re: Linux GPL and binary module exception clause?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the copyright holder, you definitely have the right
to staple restrictions on derivative works. However, I
would say your idea(if I interpet them correctly) of
derivative work is a bit broad. 

My understanding of derivative work is that it is
based on your work which is a form of expression(in
this case, I believe is the source code). If I don't
include/copy your source code, how can it be a
derivative work ? if you mean the function calls(or
should it be called kernel APIs) is copyrightable,
would it be that projects like WINE is infringing
Microsoft's copyright ?

The inclusion of kernel header is a complex issue. As
a header usually contains constant/function
definitions, structure definitions(in order to
properly working with the kernel) and sometimes inline
functions. inline functions is definitely a form of
expression which is copyrightable but for the others,
should they be classified as 'interface' than
copyright materials ? If they are copyrightable
material, I believe things like FAT should be removed
from linux as the FAT layout(thus the structure in say
C) seems to be copyrightable too.

So I would say that if a driver writer creates their
own header files which specifies the same
constant/function definitions in order to interface
with linux, I don't think their works are derivative
work of linux.

In fact, it can be argued that these are exceptions
cover in the DMCA like what the xbox-linux project
stated :

"Everything done on this project is for the sole
purpose of writing interoperable software under Sect.
1201 (f) Reverse Engineering exception of the DMCA"

the drivers would then be the "interoperable software"
for linux.

All these are just my limited understanding and
interpretation of copyright and I believe unless the
whole thing is challenged and decided in court, there
is really no real answer. May be the SCO case can make
this clear.

regards,

gary


On Friday 05 December 2003 01:14 pm, Linus Torvalds
wrote:
> On Fri, 5 Dec 2003, David Schwartz wrote:
> > Please show me the law
> > that permits a copyright holder to restrict the
distribution of
> > derived works.
> 
> The "show me the law" is USC 17. It's called "US
Copyright Law". As a
> copyright holder in the Linux kernel, I _do_ have
the right to restrict
> the distribution of derived works. That's what
copyright law is all
> about.


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
