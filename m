Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264469AbRFIMT7>; Sat, 9 Jun 2001 08:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264470AbRFIMTt>; Sat, 9 Jun 2001 08:19:49 -0400
Received: from oxmail4.ox.ac.uk ([163.1.2.33]:2517 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S264469AbRFIMTl>;
	Sat, 9 Jun 2001 08:19:41 -0400
Date: Sat, 9 Jun 2001 13:19:39 +0100
From: Ian Lynagh <igloo@earth.li>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 rpc_execute panic (OK with 2.2.17)
Message-ID: <20010609131939.A30773@stu163.keble.ox.ac.uk>
In-Reply-To: <20010609113521.A30318@stu163.keble.ox.ac.uk> <shselstyi0a.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <shselstyi0a.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Sat, Jun 09, 2001 at 02:06:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2001 at 02:06:45PM +0200, Trond Myklebust wrote:
> >>>>> " " == Ian Lynagh <igloo@earth.li> writes:
> 
>      > When trying to mount something over NFS with a 2.2.19 kernel we
>      > get:
> 
>      > Unsupported unaligned load/store trap for kernel at
>      > <00000000004d260c> Kernel panic: Wheee. Kernel does fpu/atomic
>      > unaligned load/store.
> 
> Does the following patch help?

Alan Cox said it is fixed in the 2.2.20pre kernels, so I will given one
of them a shot.

Apparently it doesn't qualify for an errata note though  :-(


Thanks for your quick response
Ian

