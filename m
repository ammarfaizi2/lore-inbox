Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130515AbQKIMkr>; Thu, 9 Nov 2000 07:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130606AbQKIMk2>; Thu, 9 Nov 2000 07:40:28 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:8911 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130515AbQKIMkY>;
	Thu, 9 Nov 2000 07:40:24 -0500
Date: Thu, 9 Nov 2000 07:40:21 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Christoph Rohland <cr@sap.com>, Larry McVoy <lm@bitmover.com>,
        richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <3A0A968B.85A6770E@holly-springs.nc.us>
Message-ID: <Pine.GSO.4.21.0011090736390.11045-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Nov 2000, Michael Rothwell wrote:

> Same as before -- freedom and low cost. The primary advantae of Linux
> over other OSes is the GPL. 

Now, that's more than slightly insulting...

The problem with the hooks et.al. is very simple - they promote every
bloody implementation detail to exposed API. Sorry, but... See Figure 1.
It won't fly.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
