Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSFEEJ0>; Wed, 5 Jun 2002 00:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317544AbSFEEJZ>; Wed, 5 Jun 2002 00:09:25 -0400
Received: from dsl-213-023-043-246.arcor-ip.net ([213.23.43.246]:37047 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314634AbSFEEJY>;
	Wed, 5 Jun 2002 00:09:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: J Sloan <joe@tmsusa.com>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Date: Wed, 5 Jun 2002 06:08:57 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206041418460.2614-100000@waste.org> <E17FQPj-0001Rr-00@starship> <3CFD8C07.6030607@tmsusa.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17FS6T-0001UR-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 June 2002 05:56, J Sloan wrote:
> Daniel Phillips wrote:
> 
> >If I recall correctly, XFS makes an attempt to provide such realtime 
> >guarantees, or at least the Solaris version does. 
> >
> When did Solaris ever support xfs?
> 
> > However, the operating 
> >system must be able to provide true realtime guarantees in order for the 
> >filesystem to provide them, and I doubt that the combination of XFS and 
> >Solaris can do that.
> >
> no, but the combination of xfs and irix has
                                     ^^^^			
Heh, I can only protest that Oxymoron also missed that thinko..

> made a lot of folks happy -  and xfs/linux is coming along nicely as
> well...

Improving the average latency of systems is a worthy goal, and there's
no denying that 'sorta realtime' has its place, however it's no substitute
for the real thing.  A soft realtime system screws up only on occasion,
but - bugs excepted - a hard realtime system *never* does.

-- 
Daniel
