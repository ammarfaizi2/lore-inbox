Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135284AbRD3OqC>; Mon, 30 Apr 2001 10:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135296AbRD3Op4>; Mon, 30 Apr 2001 10:45:56 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:62321 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S135284AbRD3Op3>; Mon, 30 Apr 2001 10:45:29 -0400
Date: Mon, 30 Apr 2001 16:45:24 +0200
From: Cliff Albert <cliff@oisec.net>
To: "Todd M. Roy" <troy@holstein.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda
Message-ID: <20010430164523.A13193@oisec.net>
In-Reply-To: <20010428202225.D11994@emma1.emma.line.org> <PGEDKPCOHCLFJBPJPLNMCEDICMAA.denali@sunflower.com> <20010429122546.A1419@werewolf.able.es> <20010430013956.A1578@emma1.emma.line.org> <200104301340.f3UDeN115068@pcx4168.holstein.com> <20010430163045.A13230@emma1.emma.line.org> <3AED7885.A2E4F91B@holstein.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3AED7885.A2E4F91B@holstein.com>; from troy@holstein.com on Mon, Apr 30, 2001 at 10:36:53AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2001 at 10:36:53AM -0400, Todd M. Roy wrote:

>   I tried 2.4.4 with the old aic7xxxx driver and it worked fine.
> 
> I have no control over that stupid, stupid mime-sweeper message.
> Thats our anal-retentive network administrators work....

2.4.4 with old aic7xxx still crashes my box, but doesn't give the warnings. 2.4.3-ac14 still works fine. even under high load on the scsi bus.

-- 
Cliff Albert		| IRCNet:    #linux.nl, #ne2000, #linux, #freebsd.nl
cliff@oisec.net		| 	     #openbsd, #ipv6, #cu2.nl
-[ICQ: 18461740]--------| 6BONE:     CA2-6BONE       RIPE:     CA3348-RIPE
