Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289527AbSAVWzw>; Tue, 22 Jan 2002 17:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289523AbSAVWzn>; Tue, 22 Jan 2002 17:55:43 -0500
Received: from ns.caldera.de ([212.34.180.1]:22431 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S289518AbSAVWz1>;
	Tue, 22 Jan 2002 17:55:27 -0500
Date: Tue, 22 Jan 2002 23:55:12 +0100
Message-Id: <200201222255.g0MMtCF09024@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: andyp@osdl.org (Andy Pfiffer)
Cc: linux-kernel@vger.kernel.org
Subject: Re: In Search Of: Old Module: "Two Kernel Monte"
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <1011739306.11541.30.camel@andyp>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1011739306.11541.30.camel@andyp> you wrote:
> Briefly, the module would load a new kernel image, ramdisk, command line
> etc. by trying to put the system back into a post-firmware state and
> launch the kernel.  It apparently lacked support for SMP systems.
>
> The original link to the code is now a dead-end: 
>
> 	http://www.scyld.com/software/monte.html
>
> and the original author is unreachable by the address listed.
>
> If you've got a copy of the code stashed somewhere, or if you know of
> more recent work in this area, I would appreciate a pointer.

I've put an SRPM of a slightly hacked version on:

	ftp.kernel.org/pub/linux/kernel/people/hch/misc/monte-0.4.0-2.src.rpm

