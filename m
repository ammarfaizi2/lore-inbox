Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315195AbSEDVfs>; Sat, 4 May 2002 17:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315197AbSEDVfr>; Sat, 4 May 2002 17:35:47 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:8715 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315195AbSEDVfr>; Sat, 4 May 2002 17:35:47 -0400
Date: Sat, 4 May 2002 23:35:34 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "M. Edward Borasky" <znmeb@aracnet.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: IO stats in /proc/partitions
Message-ID: <20020504213534.GA3034@louise.pinerecords.com>
In-Reply-To: <UTC200205041959.g44JxQa20044.aeb@smtp.cwi.nl> <HBEHIIBBKKNOBLMPKCBBCEAOEMAA.znmeb@aracnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 12 days, 16:02)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I recently spent a week trying to track down the units used for the disk stats
> in /proc/stat. Through a combination of queries on the LKML and trucking
> through the source with rgrep, I managed to get my questions answered. It
> matters to me and to the people I work for exactly how many bytes the I/O
> subsystem is handling per second, and how close to the capacity of the I/O
> subsystem a machine is operating. I consider the fact that I had to dig for
> and ask for this information unacceptable.

But hey, you've suffered thru it, which, guess what, makes you the perfect
candidate to have the honor of writing the docs!

Take care,
T.
