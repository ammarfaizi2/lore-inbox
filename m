Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129521AbQKVSaP>; Wed, 22 Nov 2000 13:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129703AbQKVSaF>; Wed, 22 Nov 2000 13:30:05 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:29705 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S129521AbQKVS3y>; Wed, 22 Nov 2000 13:29:54 -0500
Date: Wed, 22 Nov 2000 11:56:20 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: modutils 2.3.21 is available
Message-ID: <20001122115620.B18592@vger.timpanogas.org>
In-Reply-To: <6715.974895917@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <6715.974895917@ocs3.ocs-net>; from kaos@ocs.com.au on Wed, Nov 22, 2000 at 11:25:17PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2000 at 11:25:17PM +1100, Keith Owens wrote:
> This is the "never release a security fix in a hurry" release.  The
> security fixes in modutils 2.3.20 had some side effects on some config
> files.  Linus knocked back environment variable MOD_SAFEMODE, instead
> the kernel propagates the real uid that caused modprobe to be invoked.
> 
> ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.3
> 
> patch-modutils-2.3.21.bz2       Patch from modutils 2.3.20 to 2.3.21
> modutils-2.3.21.tar.bz2         Source tarball, includes RPM spec file
> modutils-2.3.21-1.src.rpm       As above, in SRPM format
> modutils-2.3.21-1.i386.rpm      Compiled with egcs-2.91.66, glibc 2.1.2
> modutils-2.3.21-1.sparc.rpm     Compiled for combined sparc 32/64
> 
> Changelog extract
> 
> 	* Remove compile warnings in xstrcat.
> 	* snprintf cleanups.
> 	* Set safemode when uid != euid.
> 	* Strip quotes from shell responses.
        + add RedHat ism's with a --rhc (red hat compatible) -i -m (-F) 

RedHat kind of is the standard in the commercial world in the US.

:-)

Jeff

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
