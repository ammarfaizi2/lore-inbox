Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265610AbRF2G2j>; Fri, 29 Jun 2001 02:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265626AbRF2G23>; Fri, 29 Jun 2001 02:28:29 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:64005 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S265610AbRF2G20>;
	Fri, 29 Jun 2001 02:28:26 -0400
Date: Fri, 29 Jun 2001 00:29:06 -0600
From: Cort Dougan <cort@fsmlabs.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
Message-ID: <20010629002906.E4348@ftsoj.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.33.0106281028170.10308-100000@localhost.localdomain> <Pine.LNX.4.33.0106281035250.15199-100000@penguin.transmeta.com> <15164.6716.301922.3947@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <15164.6716.301922.3947@cargo.ozlabs.ibm.com>; from paulus@samba.org on Fri, Jun 29, 2001 at 04:03:40PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can we then expect to see all mention of authors in drivers disappear from
the boot?  Same with url's, version #'s and the like?  The built by
user@host message is a good bit of "drumming ones own drum" while
contributing very little (running 'make' vs. writing the system).

Is the kernel boot screen so sacred that it requires us to make it the arid
wasteland that the HP-UX boot is?  This verbosity is useful in many cases
and certainly harmless.

} > There's another side to "drumming your own drum": it is often seen as
} > actively offensive to some people who don't want to do the same thing.
} 
} I agree.  What usually seems to end up happening is that someone
} writes 95% and gets no credit, someone else does 5% and puts in a
} printk announcing their contribution loudly every time the system
} boots.  I recall that the old PPP driver used to print "PPP Dynamic
} channel allocation code copyright 1995 Caldera, Inc." which always
} annoyed me because it was a completely trivial piece of code that the
} notice was referring to.
} 
} Paul.
} -
} To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
} the body of a message to majordomo@vger.kernel.org
} More majordomo info at  http://vger.kernel.org/majordomo-info.html
} Please read the FAQ at  http://www.tux.org/lkml/
