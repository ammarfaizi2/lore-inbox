Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262175AbRETTds>; Sun, 20 May 2001 15:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262168AbRETTdi>; Sun, 20 May 2001 15:33:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:38373 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262167AbRETTdY>;
	Sun, 20 May 2001 15:33:24 -0400
Date: Sun, 20 May 2001 15:33:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code 
In-Reply-To: <Pine.LNX.4.21.0105201217320.7712-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0105201530580.8940-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, Linus Torvalds wrote:

> > How about moratorium on new ioctls in the meanwhile? Whatever we do in
> > fs/ioctl.c, it _will_ take time.
> 
> Ehh.. Telling people "don't do that" simply doesn't work. Not if they can
> do it easily anyway. Things really don't get fixed unless people have a
> certain pain-level to induce it to get fixed.

Umm... How about the following:  you hit delete on patches that introduce
new ioctls, I help to provide required level of pain.  Deal?

BTW, -pre4 got new bunch of ioctls. On procfs, no less.


