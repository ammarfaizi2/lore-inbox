Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265378AbTBBPbi>; Sun, 2 Feb 2003 10:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbTBBPbi>; Sun, 2 Feb 2003 10:31:38 -0500
Received: from muriel.parsec.at ([80.120.166.1]:24590 "EHLO muriel.parsec.at")
	by vger.kernel.org with ESMTP id <S265378AbTBBPbh>;
	Sun, 2 Feb 2003 10:31:37 -0500
Date: Sun, 2 Feb 2003 16:40:39 +0100 (CET)
From: Andreas Gruenbacher <ag@bestbits.at>
X-X-Sender: <ag@muriel.parsec.at>
To: Stephen Lord <lord@sgi.com>
cc: <Andries.Brouwer@cwi.nl>, <kaos@ocs.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-xfs@oss.sgi.com>
Subject: Re: system call documentation [license question]
In-Reply-To: <1044199525.1372.8.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0302021633280.1441-100000@muriel.parsec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Feb 2003, Stephen  Lord wrote:

> On Sat, 2003-02-01 at 10:45, Andries.Brouwer@cwi.nl wrote:
> >     [...]
> >
> >     *xattr* man pages are in the XFS tree and Andreas Gruenbacher's site,
> >     contents forwarded under separate copy.
> >
> >     getxattr.2:    getxattr, lgetxattr, fgetxattr2
> >     listxattr.2:    listxattr, llistxattr, flistxattr
> >     removexattr.2:    removexattr, lremovexattr, fremovexattr
> >     setxattr.2:    setxattr, lsetxattr, fsetxattr
> >
> > Good. Thanks!
> >
> > However,
> >
> > .\" (C) Andreas Gruenbacher, February 2001
> > .\" (C) Silicon Graphics Inc, September 2001
> >
> > there is no indication that redistribution (of possibly modified
> > copies) is permitted.
> >
> > Andries
>
> There should be no problem with redistribution, I can probably get
> someone to update them soon. I presume Andreas will also have no
> problems with this.

The man pages are intended to be GPL licensed, while libacl (and libattr)
was originally intended to be under LGPL. I have been quite lazy on
putting that right into the package. I assume that nobody has any
objections. Maybe someone wants to add that information to the CVS?


Regards,
Andreas.

