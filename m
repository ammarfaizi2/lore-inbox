Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292866AbSCTAfq>; Tue, 19 Mar 2002 19:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293131AbSCTAfh>; Tue, 19 Mar 2002 19:35:37 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:52421 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S292866AbSCTAfX>; Tue, 19 Mar 2002 19:35:23 -0500
Date: Tue, 19 Mar 2002 18:34:20 -0600
From: Ken Brownfield <ken@irridia.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I/O APIC fixed in 2.4.19-pre3 & 2.5.6 (was Re: Linux 2.4.19-pre3)
Message-ID: <20020319183420.A15811@asooo.flowerfire.com>
In-Reply-To: <20020318204106.A24611@asooo.flowerfire.com> <Pine.LNX.3.96.1020319111636.1772A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If noapic doesn't fix your problem, the I/O APIC patch won't help
unfortunately, AFAIK.  Are these solid system-wide lockups not
attributable to a binary-only X driver? ;)

-- 
Ken.
ken@irridia.com

On Tue, Mar 19, 2002 at 11:22:44AM -0500, Bill Davidsen wrote:
|   Any chance this will cure the lockups on a Dell Latitude C600 every time
| you exit X? I've disabled both the IO-APIC and APIC-uni, which was
| supposed to fix the problem but didn't. Dare I hope that the disable
| wasn't enough?
| 
|   A quick google tells me other people have the same problem, but I
| haven't seen a working solution yet. Nice machine other than needing to be
| rebooted after every use of X :-(
| 
| -- 
| bill davidsen <davidsen@tmr.com>
|   CTO, TMR Associates, Inc
| Doing interesting things with little computers since 1979.
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
