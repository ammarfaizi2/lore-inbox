Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129765AbQKGECL>; Mon, 6 Nov 2000 23:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130818AbQKGEBv>; Mon, 6 Nov 2000 23:01:51 -0500
Received: from zero.tech9.net ([209.61.188.187]:1285 "EHLO tech9.net")
	by vger.kernel.org with ESMTP id <S129765AbQKGEBn>;
	Mon, 6 Nov 2000 23:01:43 -0500
Date: Mon, 6 Nov 2000 23:01:43 -0500 (EST)
From: "Robert M. Love" <rml@tech9.net>
To: Frank Davis <fdavis112@juno.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Pentium 4 and 2.4/2.5
In-Reply-To: <20001104.183646.-371331.1.fdavis112@juno.com>
Message-ID: <Pine.LNX.4.21.0011062241460.17391-100000@phantasy.awol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Nov 2000, Frank Davis hissed:
>   I noticed that Pentium 4 isn't an config option in 2.4.0-test10. Is
> someone working on a patch for the the kernel (if needed) to support the
> Pentium 4 after 2.4.0 is released?

from what i have read of the Pentium IV, the linux kernel will not need
any patches to run successfully.

that being said, a lot of oppurtunity exists for optimization, i bet. some
686-core optimizations may need to be rethought, but there is at least
some things we can better do to take advantage of the P4.  if nothing
else, the new pipeline size and cache-

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
