Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312412AbSDEJB1>; Fri, 5 Apr 2002 04:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312413AbSDEJBS>; Fri, 5 Apr 2002 04:01:18 -0500
Received: from elin.scali.no ([62.70.89.10]:36625 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S312412AbSDEJBA>;
	Fri, 5 Apr 2002 04:01:00 -0500
Date: Fri, 5 Apr 2002 11:00:59 +0200 (CEST)
From: Steffen Persvold <sp@scali.com>
To: <arjan@fenrus.demon.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] compile error in 2.4.19-pre5-ac1
In-Reply-To: <200204050741.g357fQK11963@fenrus.demon.nl>
Message-ID: <Pine.LNX.4.30.0204051008050.11252-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002 arjan@fenrus.demon.nl wrote:

> In article <Pine.LNX.4.30.0204050220590.7535-100000@elin.scali.no> you wrote:
> > Then it's a bit odd that RH ships a new kernel-headers RPM (which
> > contains the /usr/include/{linux,asm} directories) for each kernel
> > update and glibc still beeing the same, isn't it ?
>
> Yes it is; and we fixed that properly in the current beta. But note
> that the updates are minor anyway (between errata the headers don't
> actually change in general); and people complain loudly when I exclude the
> kernel-headers package.....

Wouldn't it be more logical to have the kernel-headers stuff inside the
glibc-devel package (I guess you have thought about this already...). Why
do people complain if you remove the kernel-headers package ?

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency

