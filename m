Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285036AbRLKO6q>; Tue, 11 Dec 2001 09:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285032AbRLKO6f>; Tue, 11 Dec 2001 09:58:35 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:14296 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S285036AbRLKO62>; Tue, 11 Dec 2001 09:58:28 -0500
Date: Tue, 11 Dec 2001 17:00:55 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <thockin@sun.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] eepro100 - need testers 
Message-ID: <Pine.LNX.4.33.0112111654100.10584-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem i was experiencing (albeit with 2.4.10-ac11) was losing
connectivity for 2-10s at a time, no messages in the logs, and the machine
would resume activity as normal afterwards. The machine is connected to
the network via two NICs (3c59x and eepro100) and i only get these freezes
when connecting to the IP address on the eepro100. Unfortunately, due to
the lack of error messages, this report doesn't help much. But i was
wondering wether this was what some people were experiencing.

connected via switch with moderately high network load (general purpose
server)

Cheers,
	Zwane Mwaikambo

PS i have 2.4.17-pre5 and so far haven't noticed it, but haven't done much
testing either.


