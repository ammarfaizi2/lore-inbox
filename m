Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129028AbRBGJCf>; Wed, 7 Feb 2001 04:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129568AbRBGJCQ>; Wed, 7 Feb 2001 04:02:16 -0500
Received: from dell-pe2450-1.cambridge.redhat.com ([172.16.18.1]:273 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S129028AbRBGJCN>; Wed, 7 Feb 2001 04:02:13 -0500
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI-SCI Drivers v1.1-7 released 
In-Reply-To: Your message of "Tue, 06 Feb 2001 19:06:24 MST."
             <20010206190624.C23960@vger.timpanogas.org> 
Date: Wed, 07 Feb 2001 09:01:49 +0000
Message-ID: <22678.981536509@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> More to add on the gcc 2.96 problems.  After compiling a Linux 2.4.1 
> kernel on gcc 2.91, running SCI benchmarks, then compiling on RedHat 
> 7.1 (Fischer) with gcc 2.96, the 2.96 build DROPPED 30% in throughput
> from the gcc 2.91 compiled version on the identical SAME 2.4.1 
> source tree. 

Out of interest, could you run your benchmark test against a "latest snapshot
build" of gcc?

	http://www.codesourcery.com/gcc-snapshots/

Cheers,
David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
