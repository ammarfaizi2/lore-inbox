Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264878AbUEVDI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264878AbUEVDI3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 23:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUEVDI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 23:08:29 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:47569 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S264878AbUEVDIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 23:08:25 -0400
Date: Fri, 21 May 2004 21:08:22 -0600 (MDT)
From: Stephen Smoogen <smoogen@lanl.gov>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: where is www.kernel.org ?!
In-Reply-To: <200405201924.52350.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.58.0405212107390.9222@smoogen1.lanl.gov>
References: <200405201924.52350.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Red Hat is having some problems with their OC-3 in North Carolina. They 
are trying to get it working ASAP. 


On Thu, 20 May 2004, Denis Vlasenko wrote:

>I can't see www.kernel.org.
>I thought my ISP is to blame.
>
>But traceroute using
>http://vger.kernel.org/traceroute.html
>gave similar results:
>
>Traceroute from VGER.KERNEL.ORG server at INFLOW co-location facility at the East Cost/USA site
>Result for www.kernel.org;   modeset: {AS-Query , SOA-Owner-Query , ICMP-Query }:
>
>traceroute.exe to zeus-pub.kernel.org (204.152.189.116), 30 hops max, 38 byte packets
> 1  router.redhat.com (12.107.209.254) [(null)] noc@redhat.com  139.390 ms  148.342 ms  149.684 ms
> 2  12.119.93.61 (12.119.93.61) [(null)] rm-hostmaster@ems.att.com  139.623 ms  138.592 ms  149.753 ms
> 3  tbr2-p013102.wswdc.ip.att.net (12.122.3.62) [(null)] rm-hostmaster@ems.att.com  129.658 ms  118.111 ms  139.788 ms
> 4  ggr2-p3120.wswdc.ip.att.net (12.123.9.117) [(null)] rm-hostmaster@ems.att.com  179.692 ms  147.944 ms  179.788 ms
> 5  att-gw.nyc.verio.net (192.205.32.18) [(null)] rm-hostmaster@ems.att.com  129.677 ms  138.576 ms  129.869 ms
> 6  p16-0-1-2.r20.plalca01.us.bb.verio.net (129.250.2.192) [AS2914] hostmaster@verio.net  119.499 ms  148.368 ms  129.752 ms
> 7  ge-1-1.a01.snfcca05.us.ra.verio.net (129.250.28.89) [AS2914] hostmaster@verio.net  139.687 ms  138.333 ms  169.950 ms
> 8  fa-5-2.a01.snfcca05.us.ce.verio.net (140.174.28.46) [AS2914] dns@verio.net  159.924 ms  138.570 ms  119.775 ms
> 9  * * *
>10  * * *
>11  * * *
>
>What's up?
>--
>vda
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
Stephen John Smoogen		smoogen@lanl.gov
Los Alamos National Lab  CCN-5 Sched 5/40  PH: 4-0645
Ta-03 SM-1498 MailStop B255 DP 10S  Los Alamos, NM 87545
-- You should consider any operational computer to be a security problem --
