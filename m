Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261869AbSI1PfN>; Sat, 28 Sep 2002 11:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261871AbSI1PfN>; Sat, 28 Sep 2002 11:35:13 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:44554 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S261869AbSI1PfM>; Sat, 28 Sep 2002 11:35:12 -0400
Message-Id: <200209281540.g8SFeMRX010119@pincoya.inf.utfsm.cl>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Kernel version [Was: Re: [PATCH-RFC] 4 of 4 - New problem logging macros, SCSI RAIDdevice driver]
In-reply-to: Your message of "Sat, 28 Sep 2002 09:46:35 +0200."
             <Pine.LNX.4.44.0209280934540.13549-100000@localhost.localdomain> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sat, 28 Sep 2002 11:40:22 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> said:
> On Thu, 26 Sep 2002, Linus Torvalds wrote:
> > On Thu, 26 Sep 2002, Jeff Garzik wrote:
> > > Tangent question, is it definitely to be named 2.6?
> > 
> > I see no real reason to call it 3.0.
> > 
> > The order-of-magnitude threading improvements might just come closest to
> > being a "new thing", but yeah, I still consider it 2.6.x. We don't have
> > new architectures or other really fundamental stuff. In many ways the
> > jump from 2.2 -> 2.4 was bigger than the 2.4 -> 2.6 thing will be, I
> > suspect.
> 
> i consider the VM and IO improvements one of the most important things
> that happened in the past 5 years - and it's definitely something that
> users will notice. Finally we have a top-notch VM and IO subsystem (in
> addition to the already world-class networking subsystem) giving
> significant improvements both on the desktop and the server - the jump
> from 2.4 to 2.5 is much larger than from eg. 2.0 to 2.4.

But is is as large as the jump from 1.2.x to 2.0.x?

> I think due to these improvements if we dont call the next kernel 3.0 then
> probably no Linux kernel in the future will deserve a major number. In 2-4
> years we'll only jump to 3.0 because there's no better number available
> after 2.8. That i consider to be ... boring :) [while kernel releases are
> supposed to be a bit boring, i dont think they should be _that_ boring.]

What is wrong with 2.10, or 2.256 for that matter?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
