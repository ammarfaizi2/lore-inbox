Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWJMHqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWJMHqP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 03:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWJMHqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 03:46:15 -0400
Received: from shards.monkeyblade.net ([192.83.249.58]:45226 "EHLO
	shards.monkeyblade.net") by vger.kernel.org with ESMTP
	id S1751326AbWJMHqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 03:46:14 -0400
Subject: Re: Realtime Wiki - http://rt.wiki.kernel.org
From: "J.H." <warthog9@kernel.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: webmaster@kernel.org, Darren Hart <dvhltc@us.ibm.com>,
       linux-kernel@vger.kernel.org, "Theodore Ts'o" <theotso@us.ibm.com>
In-Reply-To: <20061013073458.GK10251@pengutronix.de>
References: <200610051404.08540.dvhltc@us.ibm.com>
	 <20061013073458.GK10251@pengutronix.de>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 00:44:50 -0700
Message-Id: <1160725490.5389.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the heads up,

Demeter (the machine running the wiki) has been having some problems
that we aren't sure of.  I will get ahold of the colo-provider (OSUOSL)
and have them reboot the machine and I'll take a look at it when it
comes back up.  I'll keep you guys informed on what I find.

- John 'Warthog9' H.

On Fri, 2006-10-13 at 09:34 +0200, Robert Schwebel wrote:
> On Thu, Oct 05, 2006 at 02:04:07PM -0700, Darren Hart wrote:
> > There is now a realtime Linux wiki available here:
> > 
> > http://rt.wiki.kernel.org
> 
> The wiki server has disappeared some days ago:
> 
> rsc@isonoe:~$ traceroute rt.wiki.kernel.org
> traceroute to demeter.kernel.org (140.211.167.37), 30 hops max, 40 byte packets
>  1  gw.ptxnet.pengutronix.de (10.1.0.1)  0.168 ms  0.151 ms  0.134 ms
>  2  bsn23.fra.qsc.de (213.148.133.42)  201.959 ms  45.509 ms  46.349 ms
>  3  core2.fra.qsc.de (213.148.138.97)  48.942 ms  47.834 ms  67.510 ms
>  4  core2.dus.qsc.de (213.148.134.126)  48.706 ms  48.909 ms  49.976 ms
>  5  hsa1.dus1.gig9-0.118.eu.level3.net (62.67.36.77)  48.957 ms  48.870 ms  52.383 ms
>  6  ae-0-54.bbr2.Dusseldorf1.Level3.net (4.68.119.98)  48.350 ms
>     ae-0-52.bbr2.Dusseldorf1.Level3.net (4.68.119.34)  48.222 ms
>     ae-0-54.bbr2.Dusseldorf1.Level3.net (4.68.119.98)  49.295 ms
>  7  as-1-0.mp2.Seattle1.Level3.net (209.247.10.133)  203.723 ms
>     ae-0-0.mp1.Seattle1.Level3.net (209.247.9.121)  313.170 ms
>     as-1-0.mp2.Seattle1.Level3.net (209.247.10.133)  199.315 ms
>  8  ge-10-0.hsa2.Seattle1.Level3.net (4.68.105.7)  204.230 ms
>     ge-11-1.hsa2.Seattle1.Level3.net (4.68.105.103)  199.731 ms
>     ge-10-0.hsa2.Seattle1.Level3.net (4.68.105.7)  200.041 ms
>  9  nero-gw.Level3.net (63.211.200.246)  201.951 ms  202.821 ms  201.841 ms
> 10  corv-car1-gw.nero.net (207.98.64.177)  203.392 ms  204.247 ms 204.439 ms
> 11  * * *
> 
> Does anyone have a clue what happened?
> 
> Robert 

