Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261345AbSIZQoF>; Thu, 26 Sep 2002 12:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261372AbSIZQoF>; Thu, 26 Sep 2002 12:44:05 -0400
Received: from mail.sopris.net ([216.237.72.68]:60164 "EHLO mail.sopris.net")
	by vger.kernel.org with ESMTP id <S261345AbSIZQoE>;
	Thu, 26 Sep 2002 12:44:04 -0400
Message-ID: <003401c2657c$c5a12e60$f101010a@nathan>
From: "Nathan" <etherwolf@sopris.net>
To: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Subject: Updated to kernel 2.4.19 and now ipchains and iptables are broke.
Date: Thu, 26 Sep 2002 10:50:08 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is surely the greenest of green questions (sorry), but I finally got my
kernel re-compiled the way I want it using the 2.4.19 sources from
kernel.org. It loads, seems to be working fine, except ipchains and
iptables... ipchains insists that it is incompatible with my kernel, and
iptables isn't sure what's going on but it thinks maybe something (itself or
the kernel) needs upgrading. Well fine. I downloaded the latest versions of
ipchains/tables from rpmfind and upgraded, same thing.

Details: OS is RH 7.3 on an i686 (P3), kernel was 2.4.18-3 that comes with
RH 7.3, ipchains was 1.3.10-10, updated to 1.3.10-17 but when I do
ipchains -V, it says it's still 1.3.10 built in Sep. 2000. iptables was
1.2.5 but is now 1.2.6a.

I haven't been able to find any actual solutions off google for this... a
few people mention the same problem but no fixes. Can someone point this
rookie in the right direction to fix my packet filters? :-)

Also a quick question: can anyone give me either a real quick answer or a
link to more reading on which is better for routing/firewalling/VPN,
ipchains or iptables?

Many thanks!

# Nathan

