Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310434AbSDEHok>; Fri, 5 Apr 2002 02:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312261AbSDEHoU>; Fri, 5 Apr 2002 02:44:20 -0500
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:50081 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S310434AbSDEHoN>;
	Fri, 5 Apr 2002 02:44:13 -0500
Date: Fri, 5 Apr 2002 08:41:26 +0100
Message-Id: <200204050741.g357fQK11963@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: Steffen Persvold <sp@scali.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] compile error in 2.4.19-pre5-ac1
In-Reply-To: <Pine.LNX.4.30.0204050220590.7535-100000@elin.scali.no>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-31 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.30.0204050220590.7535-100000@elin.scali.no> you wrote:
> Then it's a bit odd that RH ships a new kernel-headers RPM (which
> contains the /usr/include/{linux,asm} directories) for each kernel
> update and glibc still beeing the same, isn't it ?

Yes it is; and we fixed that properly in the current beta. But note
that the updates are minor anyway (between errata the headers don't
actually change in general); and people complain loudly when I exclude the
kernel-headers package.....
