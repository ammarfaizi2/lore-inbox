Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129075AbRBOIhW>; Thu, 15 Feb 2001 03:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbRBOIhM>; Thu, 15 Feb 2001 03:37:12 -0500
Received: from [139.134.6.23] ([139.134.6.23]:57588 "EHLO
	mailin2.email.bigpond.com") by vger.kernel.org with ESMTP
	id <S129075AbRBOIhG>; Thu, 15 Feb 2001 03:37:06 -0500
From: Darren Tucker <dtucker@zip.com.au>
Message-Id: <200102150836.f1F8axl14743@gate.dodgy.net.au>
Subject: Re: crash 5/5 w/ memtest86
To: scott1021@mediaone.net
Date: Thu, 15 Feb 2001 19:36:59 +1100
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.32.0102141857410.1021-100000@nic-31-c31-100.mn.mediaone.net> from "Scott M. Hoffman" at Feb 14, 2001 07:06:27 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   After getting several segfaults running fetchmail, I tried memtest86 for
> the first time on my PC (Celeron 500, i810m/b from e-machines).  Five out
> of five tries from two different floppy disks crashed at 6% into test 1.

Does the machine in question have 256 MB of RAM, perchance?

I ask because 6% or 256Mb it about 15MB or so and some motherboards have a 
BIOS setting for a "memory hole at 15MB" (or something like that), which
might be the cause.

Then again, it might not.

		-Daz.

