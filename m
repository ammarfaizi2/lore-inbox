Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUDLNkY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 09:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbUDLNkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 09:40:24 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:6104 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262902AbUDLNkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 09:40:20 -0400
Message-Id: <200404121340.i3CDeIL4002016@eeyore.valparaiso.cl>
To: Ravi Kumar Munnangi <munnangi_ivar@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: multiple kernels 
In-Reply-To: Your message of "Sun, 11 Apr 2004 21:44:02 MST."
             <20040412044402.85530.qmail@web60604.mail.yahoo.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Mon, 12 Apr 2004 09:40:18 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravi Kumar Munnangi <munnangi_ivar@yahoo.com> said:
>   Iam currently using RedHat 8.0 (Linux-2.4.18-14).
>   For some reasons I want to have Linux-2.2.17 also
>   on my system.

There might be incompatibilites with the rest of the system. I'd advise
against it.

Why, in any case?

>   I can compile the new kernel but I want to skip the
> configuration part.

No way.

>                     Because Iam new to linux Iam not
> much confident of configuration process.

Just go slowly, read up on each configuration option (there is on-line help
in the configurators, e.g. "make menuconfig"), try it out and tweak from
there. A more knowledgeable person by your side the first time is very
useful...

>                                          Is there any
> way to make use of already existing configuration on
> Linux-2.4.18? Will this work?

It might. The configuration changed quite a bit... again, I'd advise
against trying it if you don't know your way around (yet).

Good luck!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
