Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314957AbSDVXyX>; Mon, 22 Apr 2002 19:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314971AbSDVXyW>; Mon, 22 Apr 2002 19:54:22 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:26642 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314957AbSDVXyW>;
	Mon, 22 Apr 2002 19:54:22 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.1 is available 
In-Reply-To: Your message of "Mon, 22 Apr 2002 01:04:12 +0200."
             <E16zQNR-0001NS-00@starship> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Apr 2002 09:54:12 +1000
Message-ID: <6557.1019519652@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2002 01:04:12 +0200, 
Daniel Phillips <phillips@bonn-fries.net> wrote:
>On Tuesday 23 April 2002 01:00, Keith Owens wrote:
>> On Sun, 21 Apr 2002 16:32:35 +0200, 
>> Daniel Phillips <phillips@bonn-fries.net> wrote:
>> >On Sunday 21 April 2002 09:43, Keith Owens wrote:
>> >> Content-Type: text/plain; charset=us-ascii
>> >> 
>> >> Release 2.1 of kernel build for kernel 2.5 (kbuild 2.5) is available.
>> >> http://sourceforge.net/projects/kbuild/, Package kbuild-2.5, download
>> >> release 2.1.
>> >
>> >Have you got an update on first-time build performance?
>> 
>> 30% faster than the existing kernel build system.
>
>Egad.  And we're waiting for what, exactly?

For me to be satisfied that the code is stable, the rewrite with go
faster stripes is less than four weeks old.

For more arch maintainers to convert 2.5.8/arch/$(ARCH) to kbuild 2.5.
i386 is converted, I am working on ia64, Tom Duffy is working on
sparc64, Greg Banks is working on superh.  I would like patches for
ppc, s390, alpha etc. as well but will go without them if necessary,
they can catch up later.

Then I will contact Linus.

