Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbRBGRPq>; Wed, 7 Feb 2001 12:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129489AbRBGRPg>; Wed, 7 Feb 2001 12:15:36 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:12292 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129107AbRBGRPY>; Wed, 7 Feb 2001 12:15:24 -0500
Date: Wed, 7 Feb 2001 11:10:34 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: David Howells <dhowells@cambridge.redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI-SCI Drivers v1.1-7 released
Message-ID: <20010207111034.C27089@vger.timpanogas.org>
In-Reply-To: <20010206190624.C23960@vger.timpanogas.org> <22678.981536509@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <22678.981536509@warthog.cambridge.redhat.com>; from dhowells@cambridge.redhat.com on Wed, Feb 07, 2001 at 09:01:49AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 09:01:49AM +0000, David Howells wrote:
> 
> > More to add on the gcc 2.96 problems.  After compiling a Linux 2.4.1 
> > kernel on gcc 2.91, running SCI benchmarks, then compiling on RedHat 
> > 7.1 (Fischer) with gcc 2.96, the 2.96 build DROPPED 30% in throughput
> > from the gcc 2.91 compiled version on the identical SAME 2.4.1 
> > source tree. 
> 
> Out of interest, could you run your benchmark test against a "latest snapshot
> build" of gcc?
> 
> 	http://www.codesourcery.com/gcc-snapshots/
> 
> Cheers,
> David


Sure.

Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
