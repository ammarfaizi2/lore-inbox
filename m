Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277245AbRJDVzZ>; Thu, 4 Oct 2001 17:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277244AbRJDVzF>; Thu, 4 Oct 2001 17:55:05 -0400
Received: from ns.caldera.de ([212.34.180.1]:16516 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S277243AbRJDVyx>;
	Thu, 4 Oct 2001 17:54:53 -0400
Date: Thu, 4 Oct 2001 23:53:57 +0200
Message-Id: <200110042153.f94LrvP29579@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: goemon@anime.net (Dan Hollis)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: CPU Temperature?
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.4.30.0110041442430.3919-100000@anime.net>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.30.0110041442430.3919-100000@anime.net> you wrote:
> On Thu, 4 Oct 2001, Alan Cox wrote:
>> > How can I access the CPU temperature, fan speed etc. from Linux?
>> > Or is this too hardware dependent to implement a common interface?
>> lm-sensors - it works well. Its shipped in some vendor trees
>
> Whats the schedule to merge with mainline kernel? Right now we have two
> i2c trees -- the one in the kernel and the one in lm-sensors...

2.4.10-ac4 contains the latest i2c code.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
