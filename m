Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278763AbRJVMPj>; Mon, 22 Oct 2001 08:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278764AbRJVMPc>; Mon, 22 Oct 2001 08:15:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:5354 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278763AbRJVMPR>;
	Mon, 22 Oct 2001 08:15:17 -0400
Date: Mon, 22 Oct 2001 08:15:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12 
In-Reply-To: <26057.1003751569@ocs3.intra.ocs.com.au>
Message-ID: <Pine.GSO.4.21.0110220811210.2294-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Oct 2001, Keith Owens wrote:

> Please, no more 2.4 changes.  Let Linus get 2.4 stable, fork 2.5 so we
> can break it on a daily basis then backport to 2.4 when it works.

and

> -ac kernels?  And have that behaviour depending on which version of
> modutils the user installed?  Not in 2.4, modutils strives for
> stability in production kernels, it is an important interface between
> the kernel and user space.
 
Correct me if I'm wrong, but two quotes above seem to contradict each other
- AFAICS arguments in the latter apply to backporting...

