Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbUCGR1e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 12:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbUCGR1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 12:27:34 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45989 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262262AbUCGR1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 12:27:31 -0500
Message-Id: <200403071619.i27GJkOZ003480@eeyore.valparaiso.cl>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.26-pre2 
In-Reply-To: Message from Eyal Lebedinsky <eyal@eyal.emu.id.au> 
   of "Sun, 07 Mar 2004 16:44:39 +1100." <404AB6C7.7010803@eyal.emu.id.au> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Sun, 07 Mar 2004 13:19:46 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eyal Lebedinsky <eyal@eyal.emu.id.au> said:
> Marcelo Tosatti wrote:
> > 
> > Hi, 
> > 
> > Here goes -pre2 -- it contains networking updates, network drivers 
> > updates, an XFS update, amongst others.
>  >
> > <jon:focalhost.com>:
> >   o [CRYPTO]: Add ARC4 module
> 
> In standard C we declare all variables at the top of a function. While
> some compilers allow extension, it is not a good idea to get used to
> them if we want portable code.

Oh, come on. This is _kernel_ code, it won't ever be compiled with anything
not GCC-compatible.

> If fails for me on Debian/stable.

What compiler is in use there?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
