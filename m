Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262441AbSJPNET>; Wed, 16 Oct 2002 09:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262481AbSJPNET>; Wed, 16 Oct 2002 09:04:19 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:48394 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S262441AbSJPNET>; Wed, 16 Oct 2002 09:04:19 -0400
Message-Id: <200210161310.g9GDA32o020583@pincoya.inf.utfsm.cl>
To: clemens@dwf.com
cc: linux-kernel@vger.kernel.org
Subject: Re: What kernels 2.4.x 2.5.x compile gcc3.2??? 
In-Reply-To: Message from clemens@dwf.com 
   of "Tue, 15 Oct 2002 12:49:37 MDT." <200210151849.g9FInbur002088@orion.dwf.com> 
Date: Wed, 16 Oct 2002 10:10:03 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

clemens@dwf.com said:
> The subject just about says it.
> What versions of 2.4.x and 2.5.x compile cleanly with
> the new gcc 3.2 that is included in most recent releases
> (in particular RH8.0)

I've tried 2.4.19 and a bunch of 2.4.20-pre on RH rawhide and 8.0 (same
gcc), smooth sailing throughout; and also 2.5.x, 39 <= x or something like
that, with glitches mostly due to work in progress only.

> The 2.4.18-14 kernel sources from RH have LOTS of patches,
> and they (well the modules) still dont compile with their
> own config file (sigh).

Have you reported that at http://bugzilla.redhat.com? After triple-checking,
that is, I doubt it very much that RH builds their distribution kernels
with something other than the standard RH tools and configurations.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
