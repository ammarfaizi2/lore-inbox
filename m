Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269176AbRHYNkN>; Sat, 25 Aug 2001 09:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269178AbRHYNkE>; Sat, 25 Aug 2001 09:40:04 -0400
Received: from mout1.freenet.de ([194.97.50.132]:10166 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S269176AbRHYNjx>;
	Sat, 25 Aug 2001 09:39:53 -0400
Date: Sat, 25 Aug 2001 14:41:53 +0200 (CEST)
From: "Axel H. Siebenwirth" <axel@hh59.org>
To: Linux Kernel Ml <linux-kernel@vger.kernel.org>
Subject: [Slightly OT] HostNameLookUps with Apache
Message-ID: <Pine.LNX.4.33.0108251435370.8858-100000@prester.hh59.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I'm sorry if this might a little be off the topic, but my problem seems to
be related with the kernel version i'm using.
I have an apache 2.0.16 webserver running on my  lan router and I had the
problem that apache doesnt lookup hostnames anymore to log these in its
logfiles. i only had the ip addresses logged by apache. this was with
kernel 2.4.7 and up. now i've
downgraded to 2.4.3-ac14 and apache now resolves the
ip's of the people who visit my website again.
so what i'm asking now is, how can that be related to the kernel version?
i always had a working resolv.conf.

best regards,
axel

