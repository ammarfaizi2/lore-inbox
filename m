Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268377AbRG3HAU>; Mon, 30 Jul 2001 03:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268380AbRG3HAA>; Mon, 30 Jul 2001 03:00:00 -0400
Received: from ccs.covici.com ([209.249.181.196]:9344 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S268377AbRG3G7u>;
	Mon, 30 Jul 2001 02:59:50 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs v183 available
In-Reply-To: <200107230502.f6N528g05023@vindaloo.ras.ucalgary.ca>
	<m3lml7yt4o.fsf@ccs.covici.com>
	<200107300353.f6U3ruc02345@mobilix.ras.ucalgary.ca>
From: John Covici <covici@ccs.covici.com>
Date: 30 Jul 2001 02:59:55 -0400
In-Reply-To: <200107300353.f6U3ruc02345@mobilix.ras.ucalgary.ca>
Message-ID: <m3lml652c4.fsf@ccs.covici.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

OK, thanks much -- but how do I build the man pages -- I saw nothing
in the source which said anything about it.

Thanks again for your quick response.

Richard Gooch <rgooch@ras.ucalgary.ca> writes:

> John Covici writes:
> > I have two questions -- please forgive me if they are somewhat dumb.
> > 
> > First, if I have the 2.4.7 source tree what patch level of devfs do I
> > have -- how is that related to the devfs 183 you announced?
> 
> Check Documentation/filesystems/devfs/ChangeLog
> 
> > Second, I need to change a driver which is now not devfs aware, but
> > hangs the kernel if devfs is not present -- where can I get
> > documentation for the devfs api?
> 
> Build the man pages: the source code has markups so that documentation
> can be automatically extracted.
> 
> 				Regards,
> 
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca

-- 
         John Covici
         covici@ccs.covici.com
