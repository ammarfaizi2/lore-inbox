Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLRXzY>; Mon, 18 Dec 2000 18:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbQLRXzP>; Mon, 18 Dec 2000 18:55:15 -0500
Received: from c1262263-a.grapid1.mi.home.com ([24.183.135.182]:28178 "EHLO
	mail.neruo.com") by vger.kernel.org with ESMTP id <S129391AbQLRXzG>;
	Mon, 18 Dec 2000 18:55:06 -0500
Subject: Re: 2.2.18 vs Inspiron
From: Brad Douglas <brad@neruo.com>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: James Simmons <jsimmons@suse.com>,
        Bob Lorenzini <hwm@ns.newportharbornet.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20001217050700.U3199@cadcamlab.org>
In-Reply-To: <Pine.LNX.4.21.0012121557330.2752-100000@newportharbornet.com>  
	<Pine.LNX.4.21.0012121631510.270-100000@euclid.oak.suse.com>  
	<20001217050700.U3199@cadcamlab.org>
Content-Type: text/plain
X-Mailer: Evolution 0.8 (Developer Preview)
Date: 18 Dec 2000 15:24:00 -0800
Mime-Version: 1.0
Message-Id: <20001218235512Z129391-439+4806@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Dec 2000 05:07:01 -0600, Peter Samuelson wrote:
> 
> [James Simmons]
> > Ah the infamous Rage Mobility chipset. Three versions of the same
> > chipset but each is very different.
> 
> I knew it was bad when ATI refuses to publish Windows drivers -- they
> basically say "get drivers from your laptop vendor, there is *no*
> generic driver that works for everyone".


That's not entirely correct.  True enough, they have a very confusing
naming scheme, but that shouldn't set us back too far.

Rage Mobility/M1 = Mach64
M3 = Rage128
M4 = Radeon

For ATI's Mach64 based cards, they chose to let the vendor pick the DAC
that best suited their needs.  While this is good from an economical
perspective, it caused massive support headaches.  Needless to say, ATI
no longer uses this model.  It's not that they refused to publish
drivers, they just screwed themselves out of being able to.

Brad Douglas
brad@neruo.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
