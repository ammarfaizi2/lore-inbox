Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131142AbRAQAJk>; Tue, 16 Jan 2001 19:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132990AbRAQAJa>; Tue, 16 Jan 2001 19:09:30 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:49146 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S132969AbRAQAJL>; Tue, 16 Jan 2001 19:09:11 -0500
Date: Tue, 16 Jan 2001 16:08:42 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Stefan Ring <e9725446@student.tuwien.ac.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.0.37 crashes immediately
In-Reply-To: <Pine.HPX.4.10.10101170034180.6998-100000@stud3.tuwien.ac.at>
Message-ID: <Pine.LNX.4.21.0101161605570.17397-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Stefan Ring wrote:

> 2.0.37+ kernels crash even before I can see the "Uncompressing linux..."
> message. I use the same configuration for 2.0.36 and 2.0.37 (basically
> it's the default configuration without anything interesting changed), and
> the latter just won't work. It also doesn't matter if I use zImage or
> bzImage. Kernel compiled with a stock redhat 4.2 (gcc 2.7.2.1). My machine
> configuration is as follows:
> 
> ASUS CUBX-E MB
> PIII Coppermine
> 512MB SDRAM
> 3c905-tx
> guillemot tnt2 m64
> ibm dtla-307030 & 305020, quantum fireball ex 6.4

Is there a reason you are using a relatively new machine like that with
such an outdated and arcane kernel (and distribution, for that
matter)? I'd suggest you upgrade to a more recent kernel and/or
distribution...it'll be a lot more stable (and not to mention secure!)

Good luck to you!

 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
