Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261897AbSI3CAJ>; Sun, 29 Sep 2002 22:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261898AbSI3CAJ>; Sun, 29 Sep 2002 22:00:09 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:29956 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S261897AbSI3CAI>; Sun, 29 Sep 2002 22:00:08 -0400
Message-Id: <200209300205.g8U259SP002834@pincoya.inf.utfsm.cl>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Tomas Szepe <szepe@pinerecords.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: sparc32 sunrpc.o 
In-Reply-To: Message from Pete Zaitcev <zaitcev@redhat.com> 
   of "Sun, 29 Sep 2002 19:56:12 -0400." <20020929195612.A3218@devserv.devel.redhat.com> 
Date: Sun, 29 Sep 2002 22:05:08 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> said:
> > Date: Sun, 29 Sep 2002 12:22:39 +0200
> > From: Tomas Szepe <szepe@pinerecords.com>
> 
> > +++ linux-2.4.20-pre8/arch/sparc/kernel/sparc_ksyms.c	2002-09-29 11:45:33.000
> 000000 +0200
> > +#ifdef CONFIG_HIGHMEM
> > +#include <asm/highmem.h>
> > +#endif
> 
> OK, this is actually correct, I think. Looks funny. :)

Do it inside the included file then?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
