Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272309AbRHXTmi>; Fri, 24 Aug 2001 15:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272307AbRHXTm2>; Fri, 24 Aug 2001 15:42:28 -0400
Received: from willow.seitz.com ([207.106.55.140]:50704 "EHLO willow.seitz.com")
	by vger.kernel.org with ESMTP id <S272309AbRHXTmS>;
	Fri, 24 Aug 2001 15:42:18 -0400
From: Ross Vandegrift <ross@willow.seitz.com>
Date: Fri, 24 Aug 2001 15:42:33 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4 broken on 486SX
Message-ID: <20010824154233.A10048@willow.seitz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

	I've tried many versions of 2.4 kernels on a 486SX that I have, and none of them will boot.  When trying to boot, I see 'Loading...............' with the dots continuing to appear.  Finally, the expected carriage return, and bam the system is dead.  The box doesn't even make it to 'Uncompressing Linux...'.  What I'm wondering, is how on earth am I supposed to figure out what is going on and fix it?  I've tried booting both with loadlin and directly off a floppy, both produce the same result.  The machine has 16M of RAM.  I do not know offhand the make of the CPU.

	Ross Vandegrift
	ross@willow.seitz.com
