Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbRBLXWw>; Mon, 12 Feb 2001 18:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129607AbRBLXWm>; Mon, 12 Feb 2001 18:22:42 -0500
Received: from monza.monza.org ([209.102.105.34]:6406 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129604AbRBLXWg>;
	Mon, 12 Feb 2001 18:22:36 -0500
Date: Mon, 12 Feb 2001 15:22:23 -0800
From: Tim Wright <timw@splhi.com>
To: Nick Papadonis <nick@coelacanth.com>
Cc: linux-kernel@vger.kernel.org, kurt@garloff.de
Subject: Re: TRM-S1040/DC395 Driver?
Message-ID: <20010212152223.A4280@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Nick Papadonis <nick@coelacanth.com>,
	linux-kernel@vger.kernel.org, kurt@garloff.de
In-Reply-To: <m3zofu7bk4.fsf@h0050bad6338d.ne.mediaone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3zofu7bk4.fsf@h0050bad6338d.ne.mediaone.net>; from nick@coelacanth.com on Sat, Feb 10, 2001 at 11:22:19AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, it's back up again now.
I've been using the patches for a couple of months with no problems.
This is on a 4-processor P6 box, so the SMP support seems sound. I only have
a CDRW attached on this SCSI bus so I can't comment on disk support etc.

Kurt, have you submitted this driver to be included into the mainstream
kernel ? It seems solid enough to me.

Regards,

Tim

On Sat, Feb 10, 2001 at 11:22:19AM -0500, Nick Papadonis wrote:
> Hi,
> 
> Anyone know where the kernel patches for the DC395U with the Tekram TRM-S1040
> chip are?
> 
> http://www.garloff.de/ appears to be down.
> 
> Will these be included in the 2.4.x kernel tree?
> 
> Thanks.
> 
> -- 
> - Nick
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
