Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268933AbRHPWhG>; Thu, 16 Aug 2001 18:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268934AbRHPWg4>; Thu, 16 Aug 2001 18:36:56 -0400
Received: from node-196.lofgren.sh ([212.214.21.196]:20230 "EHLO
	vic20.blipp.com") by vger.kernel.org with ESMTP id <S268933AbRHPWgr>;
	Thu, 16 Aug 2001 18:36:47 -0400
Date: Fri, 17 Aug 2001 00:36:29 +0200 (CEST)
From: Patrik Wallstrom <pawal@blipp.com>
To: <linux-kernel@vger.kernel.org>
Subject: Red Hat precompiled kernels and the BreezeNet-driver
Message-ID: <Pine.LNX.4.33.0108170028100.5950-100000@vic20.blipp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have forever tried to compile this BreezeNet SA-PCR/D PRO.11. I have had
Red Had 7.1 installed with a stock Red Hat kernel, and tried all the
rawhide kernels as it has been updated. The pcmcia-cs driver has always
crashed on me, and I couldn't understand why since I had reports of others
using it. Today I compiled 2.4.9 myself and right after installed the
driver, and it immediately!

What exactly differs the Red Hat kernels from any original compiled
kernel, and so much that this driver crashes the system?

The driver is found here:
 http://www.alvarion.com/Support_10010.asp?tNodeParam=35

/pawal

