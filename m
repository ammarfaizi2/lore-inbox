Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130415AbQKINCx>; Thu, 9 Nov 2000 08:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130497AbQKINCo>; Thu, 9 Nov 2000 08:02:44 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:3594 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S130415AbQKINCh>; Thu, 9 Nov 2000 08:02:37 -0500
Message-ID: <3A0AA063.DD5AB6D0@holly-springs.nc.us>
Date: Thu, 09 Nov 2000 08:02:27 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Christoph Rohland <cr@sap.com>, Larry McVoy <lm@bitmover.com>,
        richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <Pine.GSO.4.21.0011090736390.11045-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Thu, 9 Nov 2000, Michael Rothwell wrote:
> 
> > Same as before -- freedom and low cost. The primary advantae of Linux
> > over other OSes is the GPL.
> 
> Now, that's more than slightly insulting...

Well, it wasn't meant to be. I imagine RMS would make the same type of
statement -- Linux is libre, therefore superior. There's a number of
OSes that have advantages of Linux in some area; Solaris can use more
processors; QNX is real-time, smaller and still posix; Windows has
better application support (i.e., more of them); MacOS has better color
and font management. But, Linux is free. Let's say for a moment that
Linux was exactly the same as Solaris, technically. Linux would be
superior because it is licensed under the GPL, and is free; whereas
Solaris would not be.

> The problem with the hooks et.al. is very simple - they promote every
> bloody implementation detail to exposed API. Sorry, but... See Figure 1.
> It won't fly.

Figure 1?

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
