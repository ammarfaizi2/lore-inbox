Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130362AbRAWUHO>; Tue, 23 Jan 2001 15:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131451AbRAWUG5>; Tue, 23 Jan 2001 15:06:57 -0500
Received: from bakabaka.bignet.net ([64.79.64.12]:12811 "EHLO
	bakabaka.bignet.net") by vger.kernel.org with ESMTP
	id <S130362AbRAWUGj>; Tue, 23 Jan 2001 15:06:39 -0500
Date: Tue, 23 Jan 2001 15:06:21 -0500 (EST)
From: "Joshua M. Thompson" <om@bignet.net>
To: William Thompson <wt@electro-mechanical.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: M68K mac 2.2.18 doesn't compile
In-Reply-To: <20010123125454.A29940@coredump.electro-mechanical.com>
Message-ID: <Pine.LNX.4.30.0101231504400.19551-100000@maze.eng.bignet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001, William Thompson wrote:

> First few things I noticed were things left out.  I'm not sure about any of
> these.  The last thing is vmlinux doesn't link.  Tons of missing symbols.

None of the mainstream Linux kernels compile out of the box for Mac/68K
(or even for m68k in general I believe.) Go to www.mac.linux-m68k.org and
grab a current source tarball or precompiled vmlinux.gz file (we've got
2.2.18 and 2.4.0 available, although 2.4 is still a bit shakey.)

-- 
Head Developer
Big Net, Inc.
Raising Entropy for a Cooler Tomorrow

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
