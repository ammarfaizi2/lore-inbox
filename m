Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261805AbSJNCmZ>; Sun, 13 Oct 2002 22:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261808AbSJNCmZ>; Sun, 13 Oct 2002 22:42:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:30396 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261805AbSJNCmZ>;
	Sun, 13 Oct 2002 22:42:25 -0400
Date: Sun, 13 Oct 2002 22:48:15 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Hans Reiser <reiser@namesys.com>
cc: Rob Landley <landley@trommello.org>, Nick LeRoy <nleroy@cs.wisc.edu>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not
 3.0 - (NUMA)) (fwd)
In-Reply-To: <3DAA2EF9.2090408@namesys.com>
Message-ID: <Pine.GSO.4.21.0210132244470.9247-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Oct 2002, Hans Reiser wrote:

> Alexander Viro wrote:
> 
> >umount -l
> >mount --move
> >
> It seems Linux evolves faster than I can track.  These are nice features.:)

Why, thank you...

They had been there for a year or so, actually - (-l first, then --move).
Both were done as side effects of core cleanups that allowed per-process
namespaces - real work was in massaging infrastructure into the sane
shape, features came pretty much for free...

