Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286672AbSASPZ2>; Sat, 19 Jan 2002 10:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286712AbSASPZT>; Sat, 19 Jan 2002 10:25:19 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:33479 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S286672AbSASPZI>; Sat, 19 Jan 2002 10:25:08 -0500
Message-Id: <200201191524.g0JFOVbW002770@tigger.cs.uni-dortmund.de>
To: Alexander Viro <viro@math.psu.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rm-ing files with open file descriptors 
In-Reply-To: Message from Alexander Viro <viro@math.psu.edu> 
   of "Sat, 19 Jan 2002 07:29:33 EST." <Pine.GSO.4.21.0201190728120.3523-100000@weyl.math.psu.edu> 
Date: Sat, 19 Jan 2002 16:24:31 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> said:
> On 19 Jan 2002, Xavier Bestel wrote:
> > On Sat, 2002-01-19 at 13:16, Matthias Schniedermeyer wrote:

[...]

> > > cat /proc/<id>/fd/<nr> > whatever
> > > actually works.
> > 
> > Once it's unliked ? I doubt it.
> 
> Egads...  It certainly works, unlinked or not.  Please learn the basics of
> Unix filesystem semantics.

It does show up as a broken symlink for ls(1)...
-- 
Horst von Brand			     http://counter.li.org # 22616
