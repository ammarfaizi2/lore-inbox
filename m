Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271011AbRIEFWF>; Wed, 5 Sep 2001 01:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271138AbRIEFV4>; Wed, 5 Sep 2001 01:21:56 -0400
Received: from equinox.unr.edu ([134.197.1.2]:52102 "EHLO equinox.unr.edu")
	by vger.kernel.org with ESMTP id <S271011AbRIEFVj>;
	Wed, 5 Sep 2001 01:21:39 -0400
From: Eric Olson <ejolson@unr.edu>
Message-Id: <200109050521.WAA26155@equinox.unr.edu>
Subject: Re: Athlon doesn't like Athlon optimisation?
To: linux-kernel@vger.kernel.org
Date: Tue, 4 Sep 2001 22:21:58 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Robert Redelmeier told me he has written a version of his burnMMX which 
uses K7 MMX 3DNow streaming cache bypass load/store instruction sequences
similar to what is used in linux/arch/i386/lib/mmx.c

He asked me to publicise that anyone who wanted to test it could contact
him though email.  His email address is available from the burnCPU website
	http://users.ev1.net/~redelm/
The program is 168 lines of assembler and compiles for Windows or Linux.  
It runs until it detects an error.  

It would be particularly interesting if someone with a problematic KT133A 
based motherboard would test it and report back.

All the best, -Eric
