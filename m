Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130913AbQKRHeV>; Sat, 18 Nov 2000 02:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131161AbQKRHeM>; Sat, 18 Nov 2000 02:34:12 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:54791
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130913AbQKRHd7>; Sat, 18 Nov 2000 02:33:59 -0500
Date: Fri, 17 Nov 2000 23:03:51 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: ide.2.2.17.all.20001116.patch
Message-ID: <Pine.LNX.4.10.10011172251300.15659-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes osb4	ServerWorks ATA-33
Taskfile	Native.

Only because I needed this for Ute-Linux Distro, did I feel obligated to
push and do a backport to 2.2.17

Additionally DiskPerf-1.0 is available.

DO NOT ENABLE WRITE MODE OF TESTS!!!!
DESTRUCTIVE TESTS!!!!!!

IT IS CONFIGURED FOR READONLY TEST!!!!!

This package is brought to you by the following:
	ATIPA Linux Solutions
	Linux ATA Development
	Timpanogas Research Group

Use at your own RISK if modified!

Regards,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
