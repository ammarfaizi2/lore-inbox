Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130601AbQKJM6J>; Fri, 10 Nov 2000 07:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130986AbQKJM57>; Fri, 10 Nov 2000 07:57:59 -0500
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:63633 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S130601AbQKJM4p>; Fri, 10 Nov 2000 07:56:45 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: Alexander Viro <viro@math.psu.edu>
cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        Christoph Rohland <cr@sap.com>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
Message-ID: <80256993.00470452.00@d06mta06.portsmouth.uk.ibm.com>
Date: Fri, 10 Nov 2000 10:57:00 +0000
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> The problem with the hooks et.al. is very simple - they promote every
> bloody implementation detail to exposed API. ....

Surely not, having the kernel source does that. The alternative to the hook
is embed a patch in the kernel source.  What proveds greater exposure to
internals: hooks of source?


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
