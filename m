Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSFGItp>; Fri, 7 Jun 2002 04:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317256AbSFGItp>; Fri, 7 Jun 2002 04:49:45 -0400
Received: from rj.SGI.COM ([192.82.208.96]:6033 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S316789AbSFGIto>;
	Fri, 7 Jun 2002 04:49:44 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, release 3.0 is available 
In-Reply-To: Your message of "Wed, 05 Jun 2002 23:53:43 +1000."
             <26430.1023285223@ocs3.intra.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 Jun 2002 18:49:19 +1000
Message-ID: <13225.1023439759@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jun 2002 23:53:43 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>Release 3.0 of kernel build for kernel 2.5 (kbuild 2.5) is available.
>http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
>release 3.0.

New files:

kbuild-2.5-core-18
  Change from core-17.

    Add a missing case for dependency standardization.

kbuild-2.5-common-2.4.18-8
kbuild-2.5-i386-2.4.18-3

    Synchronize link order method with 2.5.20, so both 2.4 and 2.5
    versions of kbuild 2.5 use the same process.

kbuild-2.5-common-2.4.19-pre10-1
kbuild-2.5-i386-2.4.19-pre10-1

    Upgrade to 2.4.19-pre10.  Also has new link order method.

