Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132822AbRDXGac>; Tue, 24 Apr 2001 02:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132825AbRDXGaN>; Tue, 24 Apr 2001 02:30:13 -0400
Received: from snowbird.megapath.net ([216.200.176.7]:27141 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S132822AbRDXGaD>;
	Tue, 24 Apr 2001 02:30:03 -0400
Message-ID: <3AE51D6A.BA19B084@megapathdsl.net>
Date: Mon, 23 Apr 2001 23:30:02 -0700
From: Miles Lane <miles@megapathdsl.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Semi-OT] Dual Athlon support in kernel
In-Reply-To: <9DD550E9A9B0D411A16700D0B7E38BA4255520@mail.degrp.org> <20010424081512.D16845@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Tue, Apr 24, 2001 at 08:03:18AM +0200, Antwerpen, Oliver wrote:
> > I am also highly interested in information about dual Athlon (which
> > kernel/compiler/tools to use?), as we will get a dual Athlon sample before
> 
> kernel >= 2.4.3 (better >= 2.4.4pre2 for other rasons) compiled for K7 and
> CONFIG_SMP=y, compiler as usual for the kernel gcc 2.95.[43] or egcs 1.1.2.

With the recent development kernels, an Athlon SMP kernel boots and runs
fine
on a uniprocessor Athlon machine.  This was busted until a few weeks
ago.
I don't have a SMP Athlon box to test with, so I can't help you there.

	Miles
