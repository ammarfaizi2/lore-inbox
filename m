Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbSLPXca>; Mon, 16 Dec 2002 18:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSLPXca>; Mon, 16 Dec 2002 18:32:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:47442 "EHLO
	VL-MS-MR004.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S261545AbSLPXc3>; Mon, 16 Dec 2002 18:32:29 -0500
Date: Mon, 16 Dec 2002 18:27:24 -0500
From: Xavier LaRue <paxl@videotron.ca>
Subject: Dual P3 550 Katmai Bug
To: linux-kernel@vger.kernel.org
Message-id: <20021216182724.30ba0aa6.paxl@videotron.ca>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
As I asked later this day.. my L2 cache is'nt detected on my dual p3 550.
But I have another fuzy problem,
all application take more cpu power in smp ( like xmms who was taking .3% take around 3% under and SMP kernel ( I use ps axuf to say this ) ) .. I think the bug came from the kernel(2.4.18) since I build the smp kernel before adding my second processor and it was using as much cpu .. and another fuzzy problem,
Sometime ( read one time at each 15 min ) the cpu0 OR cpu1 get more and more loaded till it get 100% of cpu load and then it reget back to 0%.

My question is .. do update my kernel to a 2.4.20 ( or another version ) should fix my problem, also could upgrading to another kernel should debug my cache problem ?? BTW, I'm not using an Debian stock kernel.. I build it yesterday from real scratch.. (make clean dep; make bzImage;... ) 

My board is an AMI MegaRUM II with two p3 SL3FJ. I'm in Dual head with matrox driver for my G400.

Thank you all in advence for your solution.. 
Xavier LaRue
