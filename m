Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbTBBPTY>; Sun, 2 Feb 2003 10:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbTBBPTY>; Sun, 2 Feb 2003 10:19:24 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:57322 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S265355AbTBBPTV>;
	Sun, 2 Feb 2003 10:19:21 -0500
Subject: Re: system call documentation
From: Stephen Lord <lord@sgi.com>
To: Andries.Brouwer@cwi.nl
Cc: kaos@ocs.com.au, a.gruenbacher@computer.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
In-Reply-To: <UTC200302011645.h11GjTX02579.aeb@smtp.cwi.nl>
References: <UTC200302011645.h11GjTX02579.aeb@smtp.cwi.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Feb 2003 09:25:21 -0600
Message-Id: <1044199525.1372.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-01 at 10:45, Andries.Brouwer@cwi.nl wrote:
>     From kaos@ocs.com.au  Sat Feb  1 14:22:31 2003
> 
>     >Preparing the next man page release, I compared the list of
>     >system calls for i386 in 2.4.20 with the list of documented
>     >system calls. It looks like
>     >
>     >fgetxattr,
>     > ...
>     >are undocumented so far.
> 
>     *xattr* man pages are in the XFS tree and Andreas Gruenbacher's site,
>     contents forwarded under separate copy.
> 
>     getxattr.2:    getxattr, lgetxattr, fgetxattr2
>     listxattr.2:    listxattr, llistxattr, flistxattr
>     removexattr.2:    removexattr, lremovexattr, fremovexattr
>     setxattr.2:    setxattr, lsetxattr, fsetxattr
> 
> Good. Thanks!
> 
> However,
> 
> .\" (C) Andreas Gruenbacher, February 2001
> .\" (C) Silicon Graphics Inc, September 2001
> 
> there is no indication that redistribution (of possibly modified
> copies) is permitted.
> 
> Andries
> 
> 

There should be no problem with redistribution, I can probably get
someone to update them soon. I presume Andreas will also have no
problems with this.

Steve

--

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com



