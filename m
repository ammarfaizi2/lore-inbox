Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281564AbRKUJxo>; Wed, 21 Nov 2001 04:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281506AbRKUJxf>; Wed, 21 Nov 2001 04:53:35 -0500
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:27021 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281559AbRKUJxW>; Wed, 21 Nov 2001 04:53:22 -0500
Date: Wed, 21 Nov 2001 09:53:20 +0000 (GMT)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: <alastair@gurney>
To: <linux-kernel@vger.kernel.org>
Subject: Athlon /proc/cpuinfo anomaly [minor]
Message-ID: <Pine.GSO.4.33.0111210945590.795-100000@gurney>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a minor point: my infamous and improbable dual Athlon XP 1800+
system is now running happily under 2.4.15-pre7, but there's a slight
anomaly in the /proc/cpuinfo reporting.

CPU0 is labelled as an "AMD Athlon(tm) MP Processor 1800+", as expected.
CPU1 is instead labelled just "AMD Athlon(tm) Processor".

All other parameters are reported as identical between the two CPUs.

I know there have been some /proc/cpuinfo changes on various
architectures recently, so maybe this is related. Am I missing
something, or shouldn't they be reported as the same?

Cheers
Alastair

o o o o o o o o o o o o o o o o o o o o o o o o o o o o
Alastair Stevens           \ \
MRC Biostatistics Unit      \ \___________ 01223 330383
Cambridge UK                 \___ www.mrc-bsu.cam.ac.uk

