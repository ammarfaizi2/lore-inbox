Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129029AbQKKVr6>; Sat, 11 Nov 2000 16:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbQKKVrj>; Sat, 11 Nov 2000 16:47:39 -0500
Received: from TRAMPOLINE.THUNK.ORG ([216.175.175.172]:26884 "EHLO
	trampoline.thunk.org") by vger.kernel.org with ESMTP
	id <S129029AbQKKVr1>; Sat, 11 Nov 2000 16:47:27 -0500
Date: Sat, 11 Nov 2000 17:47:18 -0500
Message-Id: <200011112247.eABMlIW05829@trampoline.thunk.org>
To: jsimmons@suse.com
CC: kaos@ocs.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011031700150.17266-100000@euclid.oak.suse.com>
	(message from James Simmons on Fri, 3 Nov 2000 17:10:52 -0800 (PST))
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
From: tytso@mit.edu
Phone: (781) 391-3464
In-Reply-To: <Pine.LNX.4.21.0011031700150.17266-100000@euclid.oak.suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 3 Nov 2000 17:10:52 -0800 (PST)
   From: James Simmons <jsimmons@suse.com>

   >      * VGA Console can cause SMP deadlock when doing printk {CRITICAL}
   >        (Keith Owens)

   Still not fixed :-( Here is the patch again. Keith give it a try and tell
   me if it solves your problems.

Keith, have you had a chance to test the patch?  Does it fix things?  I
note that it's apparently not in test11-pre2.

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
