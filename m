Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276591AbRLWPnx>; Sun, 23 Dec 2001 10:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279768AbRLWPnn>; Sun, 23 Dec 2001 10:43:43 -0500
Received: from dc-mx08.cluster0.hsacorp.net ([209.225.8.18]:4041 "EHLO
	dc-mx08.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S276591AbRLWPnd>; Sun, 23 Dec 2001 10:43:33 -0500
Message-Id: <200112231543.fBNFh0C28576@orf.homelinux.org>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: port-based bandwidth throttling
Organization: Department of Tesselating Kumquats
X-URL: http://orf.cx
X-face: "(Qpt_9H~41JFy=C&/h^zmz6Dm6]1ZKLat1<W!0bNwz2!LxG-lZ=r@4Me&uUvG>-r\?<DcD
 b+Y'p'sCMJ
From: Leigh Orf <orf@mailbag.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Dec 2001 10:43:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is it possible to throttle the bandwidth of traffic using a specific
port or range of ports? Say I want to limit the total outgoing traffic
on ports 12345-12456 to 100 kB/s. Or limit outgoing ftp-data (port
20) traffic to 200 kB/s (not using ftp software throttling). Is there
a kernel-based way to do tihs? I've looked at shapecfg but the docs
didn't help me much, and what I've seen of the QoS stuff goes over my
head. Some examples/pointers would be great.

Leigh Orf

