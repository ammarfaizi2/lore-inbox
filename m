Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315780AbSEJDVZ>; Thu, 9 May 2002 23:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315782AbSEJDVY>; Thu, 9 May 2002 23:21:24 -0400
Received: from zok.SGI.COM ([204.94.215.101]:60859 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315780AbSEJDVY>;
	Thu, 9 May 2002 23:21:24 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Kbuild Devel <kbuild-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Announce: Kernel Build for 2.5, Release 2.4 is available 
In-Reply-To: Your message of "09 May 2002 18:46:18 MST."
             <1020995179.2911.1.camel@tduffy-lnx.afara.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 May 2002 13:21:04 +1000
Message-ID: <25985.1021000864@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 May 2002 18:46:18 -0700, 
Thomas Duffy <tduffy@directvinternet.com> wrote:
>here is kbuild-2.5-sparc64-2.5.14-2.  you still need to apply the hacks
>patch before using this from
>http://prdownloads.sourceforge.net/kbuild/linux-2.5.14-sparc64-hacks.patch.bz2.  This won't be necessary once 2.5.15 comes out as Dave has already sent these fixes to Linus. 
>
>  Changes from kbuild-2.5-sparc64-2.5.14-1 
>
>    Build against core-12 
>
>    Builds with kbuild 2.4 now as well
>
>    asm-offsets.c now uses the new thread_info offsets 
>
>    Had to use the CFLAG ugliness of ia64 to get asm-offsets.c to
>    work properly as include/asm-sparc64/system.h uses thread_info 
>    offsets.

Uploaded to http://sourceforge.net/project/showfiles.php?group_id=18813
under release 2.4.

Also uploaded are kbuild-2.5-common-2.5.15-1.bz2 and
kbuild-2.5-i386-2.5.15-1.bz2 for kernel 2.5.15 support.

