Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281904AbRKWElT>; Thu, 22 Nov 2001 23:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281984AbRKWElJ>; Thu, 22 Nov 2001 23:41:09 -0500
Received: from rj.SGI.COM ([204.94.215.100]:21161 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S281904AbRKWEk5>;
	Thu, 22 Nov 2001 23:40:57 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, Stuart Young <sgy@amc.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux FSCP (Frequently Submitted Compilation Problems)? (was: Re: Loop.c File !!!!) 
In-Reply-To: Your message of "Thu, 22 Nov 2001 21:22:49 PDT."
             <20011122212249.U1308@lynx.no> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 23 Nov 2001 15:40:09 +1100
Message-ID: <17638.1006490409@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001 21:22:49 -0700, 
Andreas Dilger <adilger@turbolabs.com> wrote:
>Well, you've seen how many times Keith points people to the FAQ on
>module versions, after they post to the list first.  You only see
>the FAQ URL at the bottom of the emails if you have previously read
>the mailing list, which most haven't.

kbuild 2.5:

Starting phase 4 (build) for installable
  CC drivers/usb/hpusbscsi.o
... gcc error messages ...
make[1]: *** [drivers/usb/hpusbscsi.o] Error 1

Kernel build failed.  Please read the FAQ at http://www.tux.org/lkml/ before sending a bug report

make: *** [phase4] Error 1


