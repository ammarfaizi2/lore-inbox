Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279906AbRKDMXL>; Sun, 4 Nov 2001 07:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279983AbRKDMXB>; Sun, 4 Nov 2001 07:23:01 -0500
Received: from dorf.wh.uni-dortmund.de ([129.217.255.136]:25609 "HELO
	mail.dorf.wh.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S279906AbRKDMWq>; Sun, 4 Nov 2001 07:22:46 -0500
Date: Sun, 4 Nov 2001 13:22:38 +0100
From: Patrick Mau <mau@oscar.prima.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.14-pre8: 'free' still reports bogus 'cached' value.
Message-ID: <20011104132238.A14511@oscar.dorf.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just compiled 2.4.14-pre8, did some bonnie++ runs
and compiled a few kernels to stress test this release.

Here's the output of 'free':

[root@tony] free
             total       used       free     shared    buffers     cached
Mem:        513336      82124     431212          0      30696 4294958092
-/+ buffers/cache:      60632     452704
Swap:       786416       4936     781480

cheers,
Patrick
