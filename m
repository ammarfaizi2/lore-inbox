Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133053AbRADNv1>; Thu, 4 Jan 2001 08:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133094AbRADNvR>; Thu, 4 Jan 2001 08:51:17 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8018 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S133061AbRADNvK>; Thu, 4 Jan 2001 08:51:10 -0500
Date: Thu, 4 Jan 2001 14:50:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Tim Waugh <tim@cyberelk.demon.co.uk>
Cc: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>,
        linux-kernel@vger.kernel.org, linux-parport@torque.net
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
Message-ID: <20010104145051.D17640@athlon.random>
In-Reply-To: <m2k88czda4.fsf@ppro.localdomain> <20010103201344.A3203@athlon.random> <m2hf3gz6yc.fsf@ppro.localdomain> <20010103223504.L32185@athlon.random> <m266jww55q.fsf@ppro.localdomain> <20010104092751.A4416@cyberelk.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010104092751.A4416@cyberelk.demon.co.uk>; from tim@cyberelk.demon.co.uk on Thu, Jan 04, 2001 at 09:27:51AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 09:27:51AM +0000, Tim Waugh wrote:
> Believe it or not, there are some printers out there that wave
> LP_POUTPA all over the place even when they're happy: they set
> LP_PERRORP to mean 'happy', which is what the check is for.

I remeber that too, that's why we still have LP_CAREFUL around.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
