Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316390AbSFDExw>; Tue, 4 Jun 2002 00:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316404AbSFDExv>; Tue, 4 Jun 2002 00:53:51 -0400
Received: from zok.SGI.COM ([204.94.215.101]:48870 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316390AbSFDExu>;
	Tue, 4 Jun 2002 00:53:50 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, release 3.0 is available 
In-Reply-To: Your message of "Mon, 03 Jun 2002 12:35:05 +1000."
             <27953.1023071705@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 04 Jun 2002 14:53:28 +1000
Message-ID: <11725.1023166408@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jun 2002 12:35:05 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>Release 3.0 of kernel build for kernel 2.5 (kbuild 2.5) is available.
>http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
>release 3.0.

New files:

kbuild-2.5-core-16
  Changes from core-15.

    Override some command line variables to ensure that they are changed.

    Replace -nostdinc with Russell King's version.

    Print full filename in warning message.

    Correct lock filename.

    Correct unmap old db (sparc64 SEGV).

    Tweak dirty flag checking.

kbuild-2.5-common-2.5.20-2.
  Changes from common-2.5.20-1.

    Correct drivers/acpi/Makefile.in, Arnd Bergmann.
   
kbuild-2.5-s390-2.5.20-1.
kbuild-2.5-s390x-2.5.20-1.

    Arnd Bergmann.

