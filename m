Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWJMHff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWJMHff (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 03:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWJMHff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 03:35:35 -0400
Received: from metis.extern.pengutronix.de ([83.236.181.26]:41620 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S1751295AbWJMHff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 03:35:35 -0400
Date: Fri, 13 Oct 2006 09:34:58 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: webmaster@kernel.org
Cc: Darren Hart <dvhltc@us.ibm.com>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <theotso@us.ibm.com>
Subject: Re: Realtime Wiki - http://rt.wiki.kernel.org
Message-ID: <20061013073458.GK10251@pengutronix.de>
References: <200610051404.08540.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200610051404.08540.dvhltc@us.ibm.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 02:04:07PM -0700, Darren Hart wrote:
> There is now a realtime Linux wiki available here:
> 
> http://rt.wiki.kernel.org

The wiki server has disappeared some days ago:

rsc@isonoe:~$ traceroute rt.wiki.kernel.org
traceroute to demeter.kernel.org (140.211.167.37), 30 hops max, 40 byte packets
 1  gw.ptxnet.pengutronix.de (10.1.0.1)  0.168 ms  0.151 ms  0.134 ms
 2  bsn23.fra.qsc.de (213.148.133.42)  201.959 ms  45.509 ms  46.349 ms
 3  core2.fra.qsc.de (213.148.138.97)  48.942 ms  47.834 ms  67.510 ms
 4  core2.dus.qsc.de (213.148.134.126)  48.706 ms  48.909 ms  49.976 ms
 5  hsa1.dus1.gig9-0.118.eu.level3.net (62.67.36.77)  48.957 ms  48.870 ms  52.383 ms
 6  ae-0-54.bbr2.Dusseldorf1.Level3.net (4.68.119.98)  48.350 ms
    ae-0-52.bbr2.Dusseldorf1.Level3.net (4.68.119.34)  48.222 ms
    ae-0-54.bbr2.Dusseldorf1.Level3.net (4.68.119.98)  49.295 ms
 7  as-1-0.mp2.Seattle1.Level3.net (209.247.10.133)  203.723 ms
    ae-0-0.mp1.Seattle1.Level3.net (209.247.9.121)  313.170 ms
    as-1-0.mp2.Seattle1.Level3.net (209.247.10.133)  199.315 ms
 8  ge-10-0.hsa2.Seattle1.Level3.net (4.68.105.7)  204.230 ms
    ge-11-1.hsa2.Seattle1.Level3.net (4.68.105.103)  199.731 ms
    ge-10-0.hsa2.Seattle1.Level3.net (4.68.105.7)  200.041 ms
 9  nero-gw.Level3.net (63.211.200.246)  201.951 ms  202.821 ms  201.841 ms
10  corv-car1-gw.nero.net (207.98.64.177)  203.392 ms  204.247 ms 204.439 ms
11  * * *

Does anyone have a clue what happened?

Robert 
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

