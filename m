Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288913AbSAESGc>; Sat, 5 Jan 2002 13:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288914AbSAESGW>; Sat, 5 Jan 2002 13:06:22 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:17286
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S288913AbSAESGH>; Sat, 5 Jan 2002 13:06:07 -0500
Date: Sat, 5 Jan 2002 11:06:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Willy Tarreau <wtarreau@free.fr>
Cc: reddog83@chartermi.net, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel-2.4.18-nj1
Message-ID: <20020105180601.GC756@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <200201051052.g05AqLb01141@ns.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201051052.g05AqLb01141@ns.home.local>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2002 at 11:52:21AM +0100, Willy Tarreau wrote:
> > Location of Linux Kernel-2.4.18-nj1
> 
> Hi Nathan,
> 
> Please don't take it bad, I don't want to flame you nor anybody, but I
> think that if everyone publicly announces his own tree with his own set
> of changes against the main kernel, many users will be lost quickly.
> 
> Once, we had "only" 3 main trees for the stable release :
>  - Linus' official kernels
>  - Alan's who did an excellent job at combining a stable core with experimental
>    drivers
>  - Andrea's kernel which is more oriented towards big servers and very high
>    loads.
> 
> Now that Alan is working on something else, I can easily understand that
> people need a branch like the one he maintained, even if the majority of his
> work has been merged into the main tree.

I'd actually argue against this.  When Alan picked up 2.2.x, there
wasn't someone else doing an -ac'ish 2.2 release as well.  Marcelo is
doing 2.4.x now, and seems to be doing a good job of making sure stable
stuff gets in, and other stuff doesn't.  The only patches that won't
make it into Marcelos tree in the very-near-term (Which is all I'll
speculate about) are the preempt (and lock-break) patches.

Please people, more trees are not always a better thing when you're all
doing the same thing.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
