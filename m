Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131038AbQKWXUq>; Thu, 23 Nov 2000 18:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131138AbQKWXU2>; Thu, 23 Nov 2000 18:20:28 -0500
Received: from [194.213.32.137] ([194.213.32.137]:17156 "EHLO bug.ucw.cz")
        by vger.kernel.org with ESMTP id <S129698AbQKWXTp>;
        Thu, 23 Nov 2000 18:19:45 -0500
Date: Thu, 23 Nov 2000 01:15:03 +0000
From: Pavel Machek <pavel@suse.cz>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: 64738 <schwung@rumms.uni-mannheim.de>, linux-kernel@vger.kernel.org
Subject: Re: Kernel bits
Message-ID: <20001123011502.C96@toy>
In-Reply-To: <974881546.3a1b830ae5202@rumms.uni-mannheim.de> <20001122112952.Y28963@mea-ext.zmailer.org> <974886395.3a1b95fb43c63@rumms.uni-mannheim.de> <20001122120916.Z28963@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001122120916.Z28963@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Wed, Nov 22, 2000 at 12:09:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> > Can't I run a i386 kernel on a ia64 machine? I know something like this
> > from HP-UX. You can choose between a 32 and a 64 bit kernel when
> > installing, so knowing that you have a 64 bit capable machine does not
> > say that you have a 64 bit kernel.
> > And I want to have the kernel bits, not the processor bits.
> 
> 	Solaris runs 32-bit kernels on 64-bit UltraSPARCs
> 	(up to Solaris version 2.6)
> 
> 	So yes, something like that MAY be possible in case
> 	of ia64, but somehow I doubt...

It definitely will be possible to run i386 linux on x86-64.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
