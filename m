Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316587AbSF0G0n>; Thu, 27 Jun 2002 02:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316608AbSF0G0m>; Thu, 27 Jun 2002 02:26:42 -0400
Received: from students.depaul.edu ([140.192.1.100]:29937 "HELO
	students.depaul.edu") by vger.kernel.org with SMTP
	id <S316587AbSF0G0l>; Thu, 27 Jun 2002 02:26:41 -0400
Message-ID: <3D1A7AB1.D4955601@students.depaul.edu>
Date: Wed, 26 Jun 2002 21:38:41 -0500
From: Larry Garfield <lgarfiel@students.depaul.edu>
Reply-To: lgarfiel@students.depaul.edu
Organization: DePaul University
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, zaurus-general@lists.sourceforge.net
Subject: Re: [Zaurus-general] Re: New Zaurus Wishlist - removable media handling
References: <Pine.LNX.3.96.1020627032159.2332J-100000@pioneer>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Rola wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Thu, 27 Jun 2002, David Golden wrote:
> 
> >
> > > And Unix filesystems were NOT designed for removable media.
> >
> > (LKML cc'd because this rant *might* be coherent enough to explain it
> > to Linux kernel hackers)
> >
> > The main problem I have with the Linux filesystems is this:

<snippink>

> As a former Amiga user and now yet another Linux user, I probably know
> what you mean. Well, I'm not a kernel engineer but maybe it could be done
> with a virtual fs like /dev - so that
> 
> 1. /dev/ is not polluted
> 2. /mnt and other real disk space is not polluted

Well, I am neither a former Amiga user nor a kernel developer (but
GNU/Linux user), so I understood MOST of what you two said. ;-)  Coming
from a user-angle, though, the main problem with the Linux file system
"style", for lack of a better word, is the unified file tree.  

What?  The unified file tree?  Yes, the unified file tree.  The idea
that the silver plastic round thing you just put into the front of the
computer is accessed.... "under" the "storage" in the computer?  Does
that, conceptually, metaphorically, make sense?  No, it doesn't.  Nor
does the need to explicitly "mount" and "umount" (the n having gotten
lost while moving from one office to another a few years back) a floppy
disk.  This is one place where, I hate to say it, drive letters a la
DOS/Windows (or some other top-level identifier) are significantly
better from a user perspective.

-- 
Larry Garfield			AIM: LOLG42
lgarfiel@students.depaul.edu	ICQ: 6817012

-- "If at first you don't succeed, skydiving isn't for you." :-)

