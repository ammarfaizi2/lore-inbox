Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbUBUO7g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 09:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbUBUO7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 09:59:36 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:38372 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261569AbUBUO7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 09:59:32 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 21 Feb 2004 14:59:29 -0000
MIME-Version: 1.0
Subject: Re: 2.6.3 RT8139too NIC problems
Message-ID: <40377251.25966.4C15915@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Linux233 kernel: NETDEV WATCHDOG: eth1: transmit timed out
> > > Linux233 kernel: eth1: link up, 10Mbps, half-duplex, lpa 0x0000
> > > Linux233 kernel: nfs: server 486Linux not responding, still trying
> > > Linux233 kernel: nfs: server 486Linux not responding, still trying
> > > Linux233 kernel: NETDEV WATCHDOG: eth0: transmit timed out
> > > Linux233 kernel: nfs: server 486Linux OK
> > > Linux233 kernel: nfs: server 486Linux OK
> > > Linux233 kernel: nfs: server 486Linux not responding, still trying
> > > Linux233 kernel: NETDEV WATCHDOG: eth0: transmit timed out
> > > Linux233 kernel: nfs: server 486Linux OK

Well, I am at a loss now or any idea what to do next.  I have tried 
everything this morning to build this an eliminate the problem.  
Whatever I do, kernel builds nice, boots nice and no problems... 
except for these NIC timeouts - it makes 2.6.3 totally unusable for 
me.

I state again, these _very_same_ cards work perfectly under any other 
kernel I have ever used over the last 3 years (like I am back on 
2.6.2 right now).

Nick

-- 
"I am not Spock", said Leonard Nimoy.
"And it is highly illogical of humans to assume so."

