Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279502AbRJXJkF>; Wed, 24 Oct 2001 05:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279495AbRJXJj5>; Wed, 24 Oct 2001 05:39:57 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:45983 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S279504AbRJXJjw>; Wed, 24 Oct 2001 05:39:52 -0400
Date: Wed, 24 Oct 2001 11:40:26 +0200
From: bert hubert <ahu@ds9a.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.13..
Message-ID: <20011024114026.A14078@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110232249090.1185-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110232249090.1185-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Oct 23, 2001 at 10:52:28PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2001 at 10:52:28PM -0700, Linus Torvalds wrote:
> 
> Things seem to be calming down a bit, which is nice.
> 
> Of course, it might possibly also be that everybody is off flaming about
> the DMCA and getting no work done ;)
> 
> Whatever the cause, here's a 2.4.13. See if you can break it,
> 
> 		Linus
> 
> ----
> final:
>  - page write-out throttling
>  - Pete Zaitcev: ymfpci sound driver update (make Civ:CTP happy with it)
>  - Alan Cox: i2o sync-up
>  - Andrea Arcangeli: revert broken x86 smp_call_function patch
>  - me: handle VM write load more gracefully. Merge parts of -aa VM

Why do we do the exciting VM things in 'final'? We are confusing people with
pre-patches that are better than actual releases!

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
Trilab                                 The Technology People
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
