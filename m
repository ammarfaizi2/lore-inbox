Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132922AbRDUUqu>; Sat, 21 Apr 2001 16:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132921AbRDUUqm>; Sat, 21 Apr 2001 16:46:42 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:17427 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132920AbRDUUqb>;
	Sat, 21 Apr 2001 16:46:31 -0400
Date: Sat, 21 Apr 2001 16:46:59 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Request for comment -- a better attribution system
Message-ID: <20010421164659.A4704@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alexander Viro <viro@math.psu.edu>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <200104212023.f3LKN7P188973@saturn.cs.uml.edu> <Pine.GSO.4.21.0104211630130.27021-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0104211630130.27021-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Apr 21, 2001 at 04:34:29PM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu>:
> The real problem is that large part of the kernel has no permanent
> maintainers. Which makes the whole (overdesigned) idea completely moot.

One of the problems this `overdesign' can help solve is actually identifying
the parts that have semi-permanent maintainers, and the parts that don't.

One way to use the meta-information, for example, would be to use it to 
periodically poll maintainers to find out if they're still active.

Another is to be able to generate reports on exactly how much of the kernel
is in "Maintained" or "Supported" status.  I think it would be worth 
making this change just so we could know that.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

What if you were an idiot, and what if you were a member of Congress?
But I repeat myself.
        -- Mark Twain


