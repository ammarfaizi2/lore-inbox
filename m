Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbTB0PyH>; Thu, 27 Feb 2003 10:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbTB0PyH>; Thu, 27 Feb 2003 10:54:07 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:2438 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S265423AbTB0PyG>;
	Thu, 27 Feb 2003 10:54:06 -0500
Message-Id: <200302271600.h1RG0Cdh011948@eeyore.valparaiso.cl>
To: Dominik Kubla <dominik@kubla.de>
cc: Kasper Dupont <kasperd@daimi.au.dk>, Miles Bader <miles@gnu.org>,
       DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts 
In-Reply-To: Your message of "Thu, 27 Feb 2003 10:11:59 BST."
             <200302271012.02283.dominik@kubla.de> 
Date: Thu, 27 Feb 2003 13:00:12 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Kubla <dominik@kubla.de> said:
> On Thursday 27 February 2003 09:12, Kasper Dupont wrote:
> > Dominik Kubla wrote:
> > > I would recommend to replace /etc/mtab with a pseudo-FS like Sun did
> > > for /etc/mnttab:
> ...
> > How does that thing behave? I have considered a /proc/mtab implementation,
> > that might be slightly similar. 
> 
> Quoting the Solaris 8 man page:

I fail to see any significant difference to /proc/mounts (possibly expanded).
Sure, /proc is the wrong place for this kind of stuff, but...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
