Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131737AbQKAWvb>; Wed, 1 Nov 2000 17:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131751AbQKAWvV>; Wed, 1 Nov 2000 17:51:21 -0500
Received: from gap.cco.caltech.edu ([131.215.139.43]:11215 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S131723AbQKAWvJ>; Wed, 1 Nov 2000 17:51:09 -0500
To: mlist-linux-kernel@nntp-server.caltech.edu
Path: wnoise
From: wnoise@ugcs.caltech.edu (Aaron Denney)
Newsgroups: mlist.linux.kernel
Subject: Re: working userspace nfs v3 for linux?
Date: 1 Nov 2000 22:22:33 GMT
Organization: California Institute of Technology, Pasadena
Message-ID: <slrn9015t8.u5t.wnoise@barter.ugcs.caltech.edu>
In-Reply-To: <linux.kernel.3A008510.FAE271A1@holly-springs.nc.us>
Reply-To: wnoise@ugcs.caltech.edu
NNTP-Posting-Host: barter.ugcs.caltech.edu
User-Agent: slrn/0.9.6.2 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2000 Michael Rothwell <rothwell@holly-springs.nc.us> wrote:
> Andi Kleen wrote:
> > On Wed, Nov 01, 2000 at 02:59:05PM -0500, Michael Rothwell wrote:
> > > Is there a working userspace nfs v3 server for linux?
> > 
> > Yes, just install user mode linux and use its v3 knfsd server.
> 
> Does anyone have any suggestions that aren't jokes, don't require a 2.4
> kernel and will work?

Well, given that this is linux-*kernel* mailing list, the answer
seems appropriate.

You didn't say you couldn't use 2.4.  And anyway, UML runs under the 
latest 2.2 kernels.

Was it a joke?  Well, maybe.  Networking isn't UML's strong point.

I am not aware of any userspace NFSv3 server.  Your best bet would
probably to take the v2 server and mutate it.  Why do you want this beast?

-- 
Aaron Denney
-><-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
