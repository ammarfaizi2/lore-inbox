Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131594AbRCQJXI>; Sat, 17 Mar 2001 04:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131595AbRCQJW6>; Sat, 17 Mar 2001 04:22:58 -0500
Received: from balu.sch.bme.hu ([152.66.224.40]:36233 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S131594AbRCQJWk>;
	Sat, 17 Mar 2001 04:22:40 -0500
Date: Sat, 17 Mar 2001 10:21:52 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: LDT allocated for cloned task!
Message-ID: <Pine.GSO.4.30.0103171018420.13327-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi all,

When I was starting X, I got this in the syslog:

Mar 17 10:19:20 brefatox kernel: LDT allocated for cloned task!

_What is this?_. A grep on /var/log/messages shows that I had this several
times. I'm using ext2fs on an IDE drive.

Tell me what more info I can provide.

Balazs Pozsar.

