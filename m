Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312205AbSCRGLz>; Mon, 18 Mar 2002 01:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312206AbSCRGLq>; Mon, 18 Mar 2002 01:11:46 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:4574 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312205AbSCRGL3>; Mon, 18 Mar 2002 01:11:29 -0500
Date: Sun, 17 Mar 2002 23:11:24 -0700
Message-Id: <200203180611.g2I6BOk13021@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Another entry for the MCE-hang list
In-Reply-To: <3C9582F0.7090102@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> Richard Gooch wrote:
> 
> >  Hi, all. I just booted 2.4.19-pre3, and it hung right after the MCE
> >message. This is an Asus P2B-D with two Intel 450 MHz PIII's. Output
> >of /proc/cpuinfo appended.
> >
> 
> My ASUS P2B-D with dual P-II 400's is strange...
> 
> I -was- getting the hang, but then I recompiled on a different host, 
> with possibly a different compiler, and the hang went away.  Sorry I 
> cannot be more specific than this :(
> 
> The "running ok" case, which came -after- the hang case, was 
> 2.4.19-pre3-BK-latest with gcc 3.0.4-MDK.

I'm using egcs-1.1.2. I've bailed out of gcc-2.95.3 because it's
buggy. 


				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
