Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKCXUw>; Fri, 3 Nov 2000 18:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbQKCXUm>; Fri, 3 Nov 2000 18:20:42 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:2820 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S129033AbQKCXU2>;
	Fri, 3 Nov 2000 18:20:28 -0500
Message-Id: <200011020207.eA227f119842@sleipnir.valparaiso.cl>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: linux-kernel@vger.kernel.org
Subject: Re: working userspace nfs v3 for linux? 
In-Reply-To: Message from Michael Rothwell <rothwell@holly-springs.nc.us> 
   of "Wed, 01 Nov 2000 16:03:12 CDT." <3A008510.FAE271A1@holly-springs.nc.us> 
Date: Wed, 01 Nov 2000 23:07:41 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rothwell <rothwell@holly-springs.nc.us> said:
> Andi Kleen wrote:
> > On Wed, Nov 01, 2000 at 02:59:05PM -0500, Michael Rothwell wrote:
> > > Is there a working userspace nfs v3 server for linux?

> > Yes, just install user mode linux and use its v3 knfsd server.

> Does anyone have any suggestions that aren't jokes, don't require a 2.4
> kernel and will work?

2.2.18pre18 in-kernel NFSv3 (client and server) appears to work against
Solaris 2.6 (light testing with nfs-utils-2.1.1)
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
