Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132912AbRDUUe6>; Sat, 21 Apr 2001 16:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132901AbRDUUet>; Sat, 21 Apr 2001 16:34:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:45782 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132909AbRDUUef>;
	Sat, 21 Apr 2001 16:34:35 -0400
Date: Sat, 21 Apr 2001 16:34:29 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: esr@thyrsus.com, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Request for comment -- a better attribution system
In-Reply-To: <200104212023.f3LKN7P188973@saturn.cs.uml.edu>
Message-ID: <Pine.GSO.4.21.0104211630130.27021-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Apr 2001, Albert D. Cahalan wrote:

> Eric S. Raymond writes:
> 
> > This is a proposal for an attribution metadata system in the Linux
> > kernel sources.  The goal of the system is to make it easy for
> > people reading any given piece of code to identify the responsible
> > maintainer.  The motivation for this proposal is that the present
> > system, a single top-level MAINTAINERS file, doesn't seem to be
> > scaling well.
> 
> It is nice to have a single file for grep. With the proposed
> changes one would sometimes need to grep every file.

The real problem is that large part of the kernel has no permanent
maintainers. Which makes the whole (overdesigned) idea completely moot.

