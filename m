Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262893AbSJATH3>; Tue, 1 Oct 2002 15:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262894AbSJATH3>; Tue, 1 Oct 2002 15:07:29 -0400
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:26128 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S262893AbSJATH2>; Tue, 1 Oct 2002 15:07:28 -0400
Date: Tue, 1 Oct 2002 21:12:49 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@codemonkey.org.uk>, venom@sns.it,
       Alexander Viro <viro@math.psu.edu>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
Message-ID: <20021001191249.GJ15537@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Dave Jones <davej@codemonkey.org.uk>, venom@sns.it,
	Alexander Viro <viro@math.psu.edu>,
	Joe Thornber <joe@fib011235813.fsnet.co.uk>,
	Linus Torvalds <torvalds@transmeta.com>
References: <Pine.GSO.4.21.0210011010380.4135-100000@weyl.math.psu.edu> <Pine.LNX.4.43.0210011650490.12465-100000@cibs9.sns.it> <20021001154808.GD126@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001154808.GD126@suse.de>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Oct 2002, Dave Jones wrote:

> On Tue, Oct 01, 2002 at 04:52:44PM +0200, venom@sns.it wrote:
>  > A Logical Volume Manager is needed on Unix servers, and so it is needed
>  > also on Linux.
>  > If this LVM is obsoleted, then when will LVM2 be merged?
>  > really we cannot have a 2.6 or 3.0 tree without a Volume Manager, it would
>  > be a big fault.
> 
> No-one suggested 2.6.0 shipping without /something/, but having a dead
> LVM1 in _2.5_ doesn't help anyone. We've gone 6 months with it being in
> a broken/uncompilable state, going another month without it isn't a big
> deal. Getting something in before halloween is however a goal the
> Sistina folks should be aiming for.

How about EVMS kernel-space merge instead?
