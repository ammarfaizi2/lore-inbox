Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267349AbUHSUKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267349AbUHSUKy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 16:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUHSUKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 16:10:54 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:6082 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S267349AbUHSUKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 16:10:51 -0400
Message-Id: <200408192010.i7JKAffv005998@laptop14.inf.utfsm.cl>
To: jmerkey@comcast.net
cc: linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: kallsyms 2.6.8 address ordering 
In-Reply-To: Message from jmerkey@comcast.net 
   of "Thu, 19 Aug 2004 18:10:25 GMT." <081920041810.18883.4124ED110002BABC000049C32200748184970A059D0A0306@comcast.net> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Thu, 19 Aug 2004 16:10:41 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey@comcast.net said:

> I've noticed that LKML of late is unresponsive to a lot bug posts

This is a community of _volunteers_, if you want your particular itch
scratched ASAP, shop for a maintenance contract.

>                                                                   and
> that email is being blocked for a lot of folks.

I've been on this list for quite some time, and this is the very first time
I hear anything about such a thing. Care to elaborate?

[Yes, there are people who are almost universally on killfiles of the lead
 hackers, but that is their own fault... and the list managers don't need
 to bann anybody that way ;-]

>                                                  It smells like partisan
> politics based on economic motivations and its not really "open" any more
> when people stoop to this level of behavior.

Proof, please.

>                                               That aside:

> kallsyms in 2.6.8 is presenting module symbol tables with out of order
> addresses in 2.6.X.  This makes maintaining a commercial kernel debugger
> for Linux 2.6 kernels nighmareish.

If you want that fixed so you can make money off Linux, you'd better well
pay for the privilege of having your particular desires taken care of.
Probably off this list, as kernel debuggers in general are persona non
grata here, commercial software meddling with the inards of the kernel even
less wellcome.

[...]

> I don't expect a response so I'll keep coding around the broken Linux 2.6
> code but I wanted to post a record of this so perhaps someone will think
> about over-engineering systems which should be left alone.

This is probably just working to get the most out of the kernel, and the
constraint of "making kernel debuggers easy to write" just isn't in the
requirements. The kernel hackers (rightly so, IMVHO) reserve the right to
change interfases at the drop of a hat. If third parties get burned, just
too bad.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
