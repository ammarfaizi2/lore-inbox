Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131662AbRC0WvR>; Tue, 27 Mar 2001 17:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131889AbRC0WvH>; Tue, 27 Mar 2001 17:51:07 -0500
Received: from iplsin1-52-230.biz.dsl.gtei.net ([4.3.52.230]:46527 "HELO
	avenir.dhs.org") by vger.kernel.org with SMTP id <S131662AbRC0WvB>;
	Tue, 27 Mar 2001 17:51:01 -0500
Date: Tue, 27 Mar 2001 17:50:41 -0500 (EST)
From: John Madden <weez@freelists.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2 and NETDEV WATCHDOG
Message-ID: <Pine.LNX.4.21.0103271744260.3065-100000@avenir.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm receiving the following errors while botting a previously-fine 2.2
machine (Dell 2450, 2 eepro 100's):

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out: status f048  0c00 at 0/28 command 001a000

(repeating with different status codes..)

Any thoughts?

John



