Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312326AbSDJBL2>; Tue, 9 Apr 2002 21:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312331AbSDJBL1>; Tue, 9 Apr 2002 21:11:27 -0400
Received: from rj.SGI.COM ([204.94.215.100]:24805 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S312326AbSDJBL0>;
	Tue, 9 Apr 2002 21:11:26 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
Cc: kbuild-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available 
In-Reply-To: Your message of "09 Apr 2002 12:00:55 MST."
             <1018378855.6436.36.camel@tduffy-lnx.afara.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Apr 2002 11:11:02 +1000
Message-ID: <1476.1018401062@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 Apr 2002 12:00:55 -0700, 
Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu> wrote:
>Ok, with core-3, now kbuild 2.5 v2.0 works on sparc64.  There was one
>typo in one sparc64 Makefile.in from 1.12.  Attached is the patch to fix
>this.
>
>Also attached is the full kbuild 2.0 patch for sparc64 2.4.18 tree.

Thanks Tom.  Uploaded as
http://prdownloads.sourceforge.net/kbuild/kbuild-2.5-sparc64-2.4.18-1.bz2

I will get 2.5.8-pre2 working and upload that then wait for a couple of
days to see if any other arch maintainers have kbuild 2.5 patches.
Then it will be time for Release 2.1 which will be a candidate to go to
Linus.

