Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279285AbRJWGpr>; Tue, 23 Oct 2001 02:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279288AbRJWGp2>; Tue, 23 Oct 2001 02:45:28 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:1035 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S279285AbRJWGpT>;
	Tue, 23 Oct 2001 02:45:19 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200110230645.f9N6jXq402899@saturn.cs.uml.edu>
Subject: Re: The new X-Kernel !
To: chromi@cyberspace.org (Jonathan Morton)
Date: Tue, 23 Oct 2001 02:45:33 -0400 (EDT)
Cc: lgb@lgb.hu, linux-kernel@vger.kernel.org
In-Reply-To: <a05100314b7f8369cf7cd@[192.168.239.101]> from "Jonathan Morton" at Oct 21, 2001 09:33:34 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Morton writes:

> And if they *do* understand it, from a dispassionate point of view, 
> it does seem to make sense to put graphics drivers in the kernel - 
> they're implemented as "device drivers" in every other desktop OS. 
...
> But they don't realise that XFree86 has an *enormous* amount of 
> developer time behind it, which would need to be duplicated to make 
> it work in kernel space with full backwards compatibility.  Oh, and 
> did I mention this would all be for one platform - XFree86 is 
> designed to run on many!  It would also bloat the kernel tremendously.

So true... but for that bloat you get your oops and panic messages
on the screen, get cooperation with the VM, and reduce latency.

Other platforms? You're dreaming if you think they matter.
If video had been in Linux from the start, XFree86 would not be
alive today and that would have pretty much killed BSD. (OK w/ me)
Even today, I strongly suspect that XFree86 (and most of GNU BTW)
couldn't live without Linux providing developers.
