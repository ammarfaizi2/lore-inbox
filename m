Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129484AbQKTSeS>; Mon, 20 Nov 2000 13:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129234AbQKTSeI>; Mon, 20 Nov 2000 13:34:08 -0500
Received: from quark.analogic.com ([204.178.40.236]:7428 "EHLO
	quark.analogic.com") by vger.kernel.org with ESMTP
	id <S129289AbQKTSeB>; Mon, 20 Nov 2000 13:34:01 -0500
Date: Mon, 20 Nov 2000 13:04:35 -0500 (EST)
From: "Charles Turner, Ph.D." <cturner@quark.analogic.com>
Reply-To: cturner@quark.analogic.com
To: Tigran Aivazian <tigran@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Defective Red Hat Distribution poorly represents Linux
In-Reply-To: <Pine.LNX.4.21.0011201402260.1575-100000@penguin.homenet>
Message-ID: <Pine.LNX.3.95.1001120130403.3036D-100000@quark.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2000, Tigran Aivazian wrote:

> On Mon, 20 Nov 2000, Charles Turner, Ph.D. wrote:
> > 	I certainly don't know what to purchase for my
> > 	next attempt at a "shrink-wrap" installation.
> 
> Try Red Hat 7.0 -- it is certainly better. True, no distribution is
[SNIPPED...]

I just got in after trying to recover from the 500++ mile
trips yesterday.

I will answer all with this short response. Only one will be
forwarded to linux-kernel.

(1)	Most nasty-grams were from those who didn't even read the subject.
	And yes, it should be of great concern to those on the linux-
	kernel development list. The most visible advocate of Linux
	is Red Hat. When they drop the ball, it's a concern for all
	the developers.

(2)	I got about 32 private responses from folks who wanted to help.
	Thank you to all of them.

(3) 	One Red Hat employee stated that the distribution must have
	been hacked. I think it's a bit hard to rewrite Distribution
	CD-ROMS. He also didn't know that the boot occurs with initrd,
	requiring the proper modules to be loaded from the RAM disk
	before the SCSI hard disk could be accessed.

(4)	For those who think the hardware is broken; The hardware worked
	for six months using Windows/2000. It has a NT core.

	The distribution was reinstalled with only one CPU installed.
	When that failed, I changed to the other CPU and tried again.

	Then I installed only one 'stick' of RAM (128 meg). Then
	I tried to install the distribution again.

	I did this 4 times for each of the four sticks of RAM.

	In every case, the distribution failed to make a bootable
	system. However, in each case I booted it on a 2.2.17
	rescue disk and it worked.

(5)	Again, the system works fine when a 'homemade' distribution
	using the current glibc, gcc compiler, and linux-2.2.17
	are used. I have kept all the tools listed in
	linux/Documentation/Changes current on this hard disk.

(6)	One of my co-workers pointed out that the distribution
	kernel does a test for MMX speed upon startup. It then
	will use MMX for copies, etc., if it finds it's fast.
	He pointed out that this was not very mature around the
	time this distribution was made. It probably was not well
	tested and may be the reason for network daemons dying.

	This distribution was purchased in July of this year.
	If a 4 month old distribution is "obsolete", as one
	respondent said, then we had all better give up.


   Very Truly Yours,

   Charles Turner

Member(s) IEEE, IEEE Computer Society, AIAA  

          I speak only for myself, which is enough of a problem.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
