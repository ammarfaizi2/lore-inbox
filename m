Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265241AbUEUX56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265241AbUEUX56 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264886AbUEUXy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:54:26 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:34057 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265173AbUEUXfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:35:48 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: where is www.kernel.org ?!
Date: Thu, 20 May 2004 19:24:52 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405201924.52350.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't see www.kernel.org.
I thought my ISP is to blame.

But traceroute using
http://vger.kernel.org/traceroute.html
gave similar results:

Traceroute from VGER.KERNEL.ORG server at INFLOW co-location facility at the East Cost/USA site
Result for www.kernel.org;   modeset: {AS-Query , SOA-Owner-Query , ICMP-Query }:

traceroute.exe to zeus-pub.kernel.org (204.152.189.116), 30 hops max, 38 byte packets
 1  router.redhat.com (12.107.209.254) [(null)] noc@redhat.com  139.390 ms  148.342 ms  149.684 ms
 2  12.119.93.61 (12.119.93.61) [(null)] rm-hostmaster@ems.att.com  139.623 ms  138.592 ms  149.753 ms
 3  tbr2-p013102.wswdc.ip.att.net (12.122.3.62) [(null)] rm-hostmaster@ems.att.com  129.658 ms  118.111 ms  139.788 ms
 4  ggr2-p3120.wswdc.ip.att.net (12.123.9.117) [(null)] rm-hostmaster@ems.att.com  179.692 ms  147.944 ms  179.788 ms
 5  att-gw.nyc.verio.net (192.205.32.18) [(null)] rm-hostmaster@ems.att.com  129.677 ms  138.576 ms  129.869 ms
 6  p16-0-1-2.r20.plalca01.us.bb.verio.net (129.250.2.192) [AS2914] hostmaster@verio.net  119.499 ms  148.368 ms  129.752 ms
 7  ge-1-1.a01.snfcca05.us.ra.verio.net (129.250.28.89) [AS2914] hostmaster@verio.net  139.687 ms  138.333 ms  169.950 ms
 8  fa-5-2.a01.snfcca05.us.ce.verio.net (140.174.28.46) [AS2914] dns@verio.net  159.924 ms  138.570 ms  119.775 ms
 9  * * *
10  * * *
11  * * *

What's up?
--
vda

