Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314906AbSDVXBC>; Mon, 22 Apr 2002 19:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314908AbSDVXBB>; Mon, 22 Apr 2002 19:01:01 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:3090 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314906AbSDVXBA>;
	Mon, 22 Apr 2002 19:01:00 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.1 is available 
In-Reply-To: Your message of "Sun, 21 Apr 2002 16:32:35 +0200."
             <E16zIOJ-0001Fh-00@starship> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Apr 2002 09:00:49 +1000
Message-ID: <5900.1019516449@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Apr 2002 16:32:35 +0200, 
Daniel Phillips <phillips@bonn-fries.net> wrote:
>On Sunday 21 April 2002 09:43, Keith Owens wrote:
>> Content-Type: text/plain; charset=us-ascii
>> 
>> Release 2.1 of kernel build for kernel 2.5 (kbuild 2.5) is available.
>> http://sourceforge.net/projects/kbuild/, Package kbuild-2.5, download
>> release 2.1.
>
>Have you got an update on first-time build performance?

30% faster than the existing kernel build system.

>By the way, is there a reason for not providing a single bzip of all the
>2.4 + 2.5 files?  Not that the slight inconvenience matters all that much,
>since hopefully it will all be in mainline soon.

Everybody needs different bits (2.4 vs 2.5, i386 vs ia64) and each bit
is being updated separately.

