Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBMUQG>; Tue, 13 Feb 2001 15:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129042AbRBMUP5>; Tue, 13 Feb 2001 15:15:57 -0500
Received: from jdewell.coloc.xmission.com ([204.228.135.205]:21633 "HELO
	a.smtp.woods.net") by vger.kernel.org with SMTP id <S129027AbRBMUPt>;
	Tue, 13 Feb 2001 15:15:49 -0500
Date: Tue, 13 Feb 2001 13:17:53 -0700 (MST)
From: Aaron Dewell <acd@woods.net>
To: Rogerio Brito <rbrito@iname.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x SMP blamed for Xfree 4.0 crashes
In-Reply-To: <20010213175532.C4399@iname.com>
Message-ID: <Pine.GSO.4.10.10102131316390.3929-100000@spruce.woods.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BTW, same result on sparc32 smp+X.  xfs segfaults, so does X itself.  It
doesn't even get to trying to start.  I didn't even think of trying to 
go back to a UP kernel.  I'll have to try that now.

Aaron

On Tue, 13 Feb 2001, Rogerio Brito wrote:
> On Feb 13 2001, Alan Cox wrote:
> > Yeah I've seen this claim repeatedly. XFree 4.0.2 crashes for me in similar
> > ways on 3dfx and matrox cards and it happens with 2.2 kernels as well.
> 
> 	I thought that I was going crazy or that it was just my
> 	inability to configure things correctly, but it is kind of
> 	comforting to see that I'm not the only one seeing problems
> 	with XFree86 4.0.2 + matrox + kernel 2.2.18 (UP system -- an
> 	AMD Duron with chipset KT133).
> 
> 	When X 4.0.2 entered the Debian testing distribution, I
> 	immediately upgraded (I had used X 4.0.1 before with very good
> 	results, but that system had an HD crash and I reinstalled
> 	Debian potato, that comes with X 3.3.6). I got all these
> 	strange Segfaults and crashes with a vanilla 2.2.18 kernel. I
> 	went back to X 3.3.6 and everything is running perfectly fine
> 	since then, but I'd like to use the new features of X 4.
> 
> 
> 	[]s, Roger...

