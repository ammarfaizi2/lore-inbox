Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133073AbRDWNkq>; Mon, 23 Apr 2001 09:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133083AbRDWNk0>; Mon, 23 Apr 2001 09:40:26 -0400
Received: from POBOX.UPENN.EDU ([128.91.2.38]:12041 "EHLO pobox.upenn.edu")
	by vger.kernel.org with ESMTP id <S133073AbRDWNkU>;
	Mon, 23 Apr 2001 09:40:20 -0400
From: Michael J Clark <clarkmic@pobox.upenn.edu>
Message-Id: <200104231340.f3NDeJu29169@pobox.upenn.edu>
Subject: P4 problem with 2.4.3
To: linux-kernel@vger.kernel.org
Date: Mon, 23 Apr 2001 09:40:19 -0400 (EDT)
X-Mailer: ELM [version 2.4 PL23-upenn3.3]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

Im trying to get the 2.4.3 Kernel on a Dell dimension 8100 (p4, 1.3ghz).  
The 2.2* kernels work fine but when I start up with the new kernel it 
dies at the line "cpu:0, clocks:0, slice:0".  It also says something about 
"wierd, boot kernel (CPU#0) not found in BIOS. "  There is also a message 
that said Host Bus speed is 0.00mhz.  It gets the processor speed right 
though.  I chose the P4 family in the kernel compilation. I also tried 
the P3 family.

Sorry for the lack of detailed info, didn't leave a log (that I could 
find).  Thanks

Mike
