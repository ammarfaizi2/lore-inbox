Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbUKETG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbUKETG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 14:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbUKETG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 14:06:56 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:47262 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261164AbUKETGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 14:06:42 -0500
Message-Id: <200411051906.iA5J6XJd014410@laptop11.inf.utfsm.cl>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: davids@webmaster.com, jp@enix.org, linux-kernel@vger.kernel.org
Subject: Re: Possible GPL infringement in Broadcom-based routers 
In-Reply-To: Message from "Adam J. Richter" <adam@yggdrasil.com> 
   of "Sat, 06 Nov 2004 02:40:35 -0800." <200411061040.iA6AeZp03452@freya.yggdrasil.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 05 Nov 2004 16:06:33 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> said:

[...]

> 	I think you're missing the idea that that such drivers are
> _contributory_ infringement to the direct infringement that occurs when
> the user loads the module.  In other words, even for a driver that has
> not a byte of code derived from the kernel, if all its uses involve it
> being loaded into a GPL'ed kernel to form an infringing derivative
> work in RAM by the user committing direct copyright infringement against
> numerous GPL'ed kernel components, then it fails the test of having
> a substantial non-infringing use, as established in the Betamax decision,
> and distributing it is contributory infringement of those GPL'ed
> components of the kernel.

This is nonsense: If so, I'd be commiting a crime each time I fire up emacs
on Solaris (linking (GPLed) emacs to (propietary) libc in RAM). [Yes, just
an example; haven't done so for the best part of 5 years now...]

Besides, Linus has _explicitly_ said that binary (closed source) modules
are OK (under certain conditions). And AFAIU there was legitimate
discussion wether this particular excemption was required at al.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
