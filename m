Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274299AbRKDTaX>; Sun, 4 Nov 2001 14:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274368AbRKDTaE>; Sun, 4 Nov 2001 14:30:04 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:23218 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274299AbRKDTaB> convert rfc822-to-8bit;
	Sun, 4 Nov 2001 14:30:01 -0500
Date: Sun, 4 Nov 2001 14:29:06 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
cc: John Levon <moz@compsoc.man.ac.uk>, linux-kernel@vger.kernel.org,
        Daniel Phillips <phillips@bonn-fries.net>, Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <20011104200452.L14001@unthought.net>
Message-ID: <Pine.GSO.4.21.0111041413390.21449-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Nov 2001, [iso-8859-1] Jakob Østergaard wrote:

> I'm a little scared when our VFS guy claims he never heard of excellent
> programmers using scanf in a way that led to parse errors.

I've seen excellent programmers fscking up use of && and ||.

I've also seen quite a few guys coming (from their experience) to
the conclusions that look an awful lot similar to mine.  Like, say it,
dmr and ken.  Or Linus.  Or Rob Pike.  Or Brian Kernighan.

And frankly, when I hear about "typed" interfaces, two things come to
mind - "typed files" and CORBA.  Both - architectural failures.

