Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293423AbSCKA4N>; Sun, 10 Mar 2002 19:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293425AbSCKA4F>; Sun, 10 Mar 2002 19:56:05 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:52144 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S293423AbSCKAzw>; Sun, 10 Mar 2002 19:55:52 -0500
Date: Sun, 10 Mar 2002 17:55:44 -0700
Message-Id: <200203110055.g2B0tiP24585@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "David S. Miller" <davem@redhat.com>
Cc: laforge@gnumonks.org, skraw@ithnet.com, joe@tmsusa.com,
        linux-kernel@vger.kernel.org, elsner@zrz.TU-Berlin.DE
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
In-Reply-To: <20020310.164113.01028736.davem@redhat.com>
In-Reply-To: <3C6D1E99.6070303@tmsusa.com>
	<20020227151218.78965262.skraw@ithnet.com>
	<20020310163339.H16784@sunbeam.de.gnumonks.org>
	<20020310.164113.01028736.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
>    From: Harald Welte <laforge@gnumonks.org>
>    Date: Sun, 10 Mar 2002 16:33:39 +0100
>    
>    You can buy bcm57xx based boards, where the chipset is nice but the driver
>    not really nice yet.
>    
> My tg3 driver sucks then right?  Could you send me a bug report?
> 
>    You can buy syskonnect sk98 boards, which definitely have a good chipset - 
>    but the driver doesn't support the tcp transmit zerocopy path yet.  I've
>    tried to put some pressure on SysKonnect about this - but they seem a bit
>    'slow'.
>    
> The hardware is not capable of doing it, due to bugs in the hw
> checksum implementation of the sk98 chipset.  They aren't being
> "slow" they just can't possibly implement it for you.

So what is currently the best combination of gige card/driver/cost?
What do you recommend to the budget-conscious?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
