Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278702AbRKFIfL>; Tue, 6 Nov 2001 03:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278695AbRKFIfC>; Tue, 6 Nov 2001 03:35:02 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:29886 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278673AbRKFIet>;
	Tue, 6 Nov 2001 03:34:49 -0500
Date: Tue, 6 Nov 2001 03:34:40 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Petr Baudis <pasky@pasky.ji.cz>
cc: Jakob ?stergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org,
        Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
        Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <20011106092133.X11619@pasky.ji.cz>
Message-ID: <Pine.GSO.4.21.0111060326100.27713-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Nov 2001, Petr Baudis wrote:

> > As far as I can see, I cannot read /proc/[pid]/* info using sysctl.
> That can be added. We just have existing interface, and I don't propose to
> stick on its actual state as it isn't convenient, but to extend it to cope our
> needs.

No, that cannot.  Guys, you've been told: it won't happen.  I think that
was loud and clear enough.

Can it.  Get a dictionary and look up the meaning of "veto".

Oh, and as for "let's extend existing interfaces just because we had flunked
'strings in C'" - if you need Hurd, you know where to find it.

