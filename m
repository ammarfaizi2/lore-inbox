Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268131AbUIPPHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268131AbUIPPHV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 11:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268182AbUIPPFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 11:05:01 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:24510 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S268130AbUIPO6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:58:50 -0400
Message-Id: <200409161458.i8GEwcAa028377@localhost.localdomain>
To: Linus Torvalds <torvalds@osdl.org>
cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses.. 
In-Reply-To: Message from Linus Torvalds <torvalds@osdl.org> 
   of "Wed, 15 Sep 2004 10:57:25 MST." <Pine.LNX.4.58.0409151045530.2333@ppc970.osdl.org> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Thu, 16 Sep 2004 10:58:38 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> said:
> On Wed, 15 Sep 2004, Jörn Engel wrote:
> > 
> > But it still leaves me confused.  Before I had this code:

[...]

> No, you can certainly continue to use non-void pointers. The "void __iomem
> *" case is just the typeless one, exactly equivalent to regular void
> pointer usage.
> 
> So let me clarify my original post with two points:

[...]

Could you please put the clarified message into Documentation? It would be
a shame if it got lost.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
