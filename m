Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284305AbSALJLe>; Sat, 12 Jan 2002 04:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285153AbSALJLY>; Sat, 12 Jan 2002 04:11:24 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:35755 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S284305AbSALJLQ>; Sat, 12 Jan 2002 04:11:16 -0500
Date: Sat, 12 Jan 2002 11:10:35 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <t.sailer@alumni.ethz.ch>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Power down board during suspend (ESS Solo1 2.4-OSS)
Message-ID: <Pine.LNX.4.33.0201121107001.28980-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to suspend the board in addition to what the current code does
(reset sequencer & FIFO etc...).

Tested and working on my testbox with addon PCI card.

Regards,
	Zwane Mwaikambo


