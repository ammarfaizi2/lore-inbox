Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135574AbREBPMU>; Wed, 2 May 2001 11:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135580AbREBPML>; Wed, 2 May 2001 11:12:11 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:40471 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S135574AbREBPL5>; Wed, 2 May 2001 11:11:57 -0400
Date: Wed, 2 May 2001 17:11:43 +0200
From: Cliff Albert <cliff@oisec.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: (follow-up) 2.4.4, ac1,ac2,ac3 - panics on ICMPv6 packets
Message-ID: <20010502171143.A1242@oisec.net>
In-Reply-To: <20010502083928.A30793@oisec.net> <E14uum6-0003Qn-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E14uum6-0003Qn-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, May 02, 2001 at 12:26:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2001 at 12:26:28PM +0100, Alan Cox wrote:

> >  2.4.4, ac1, ac2 AND now ac3 will panic on receiving ICMPv6 packets (like traceroute6 and ping6)
> >  See my earlier messages for panic info.
> 
> Does building without netfilter support help ?

There is no netfilter support in my kernel at all neither v4 or v6
I have got confirmed from several people that if they ping6 their box it also dies

-- 
Cliff Albert		| IRCNet:    #linux.nl, #ne2000, #linux, #freebsd.nl
cliff@oisec.net		| 	     #openbsd, #ipv6, #cu2.nl
-[ICQ: 18461740]--------| 6BONE:     CA2-6BONE       RIPE:     CA3348-RIPE
