Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVBWEBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVBWEBI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 23:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVBWEBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 23:01:08 -0500
Received: from waste.org ([216.27.176.166]:45957 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261416AbVBWEBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 23:01:04 -0500
Date: Tue, 22 Feb 2005 20:00:43 -0800
From: Matt Mackall <mpm@selenic.com>
To: Daniele Lacamera <mlists@danielinux.net>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, Carlo Caini <ccaini@deis.unibo.it>,
       Rosario Firrincieli <rfirrincieli@arces.unibo.it>
Subject: Re: [PATCH] TCP-Hybla proposal
Message-ID: <20050223040043.GC3163@waste.org>
References: <200502221534.42948.mlists@danielinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502221534.42948.mlists@danielinux.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 03:34:42PM +0100, Daniele Lacamera wrote:
> Hi
> This is the official patch to implement TCP Hybla congestion avoidance.
> 
> - "In heterogeneous networks, TCP connections that incorporate a 
> terrestrial or satellite radio link are greatly disadvantaged with 
> respect to entirely wired connections, because of their longer round 
> trip times (RTTs). To cope with this problem, a new TCP proposal, the 
> TCP Hybla, is presented and discussed in the paper[1]. It stems from an 
> analytical evaluation of the congestion window dynamics in the TCP 
> standard versions (Tahoe, Reno, NewReno), which suggests the necessary 
> modifications to remove the performance dependence on RTT.[...]"[1]
> 
> [1]: Carlo Caini, Rosario Firrincieli, "TCP Hybla: a TCP enhancement for 
> heterogeneous networks", 
> International Journal of Satellite Communications and Networking
> Volume 22, Issue 5 , Pages 547 - 566. September 2004.

It's disappointing that this paper appears to be available only
through subscription sources. If I'm mistaken, please post a URL. 

By comparison, papers on Reno, Vegas, Westwood, BicTCP, not to mention
just about every other contribution to the field of open Internet
protocols has been readily available on the net since the birth of FTP
servers.

-- 
Mathematics is the supreme nostalgia of our time.
