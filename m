Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263406AbRFNRNH>; Thu, 14 Jun 2001 13:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263407AbRFNRM6>; Thu, 14 Jun 2001 13:12:58 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:54533 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S263406AbRFNRMn>; Thu, 14 Jun 2001 13:12:43 -0400
Subject: Re: 2.2.19: eepro100 and cmd_wait issues
From: Florin Andrei <florin@sgi.com>
To: Ken Brownfield <brownfld@irridia.com>
Cc: linux-kernel@vger.kernel.org, jmadden@ivy.tec.in.us
In-Reply-To: <200106121921.OAA05009@asooo.flowerfire.com>
In-Reply-To: <200106121921.OAA05009@asooo.flowerfire.com>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 14 Jun 2001 10:12:14 -0700
Message-Id: <992538734.15063.2.camel@stantz.corp.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jun 2001 12:20:58 -0700, Ken Brownfield wrote:
> Or you could keep your hardware and try the Intel driver, which seems to 
> work fine.  It only works as a module, though.  This might also help 
> narrow the issue to a driver vs. card vs. mobo/BIOS/IRQ/APIC/etc issue.

I did that, and it seems to be the right solution. ;-) No problem until
now (i got the old problem at least once every day).

Hmmm... Seems like Intel did a good job with this driver... :-)

-- 
Florin Andrei

