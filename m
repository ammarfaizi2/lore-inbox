Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290120AbSB0AGK>; Tue, 26 Feb 2002 19:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290223AbSB0AGF>; Tue, 26 Feb 2002 19:06:05 -0500
Received: from port-212-202-134-250.reverse.qsc.de ([212.202.134.250]:35542
	"EHLO hannover-internet.de") by vger.kernel.org with ESMTP
	id <S290229AbSB0AFY>; Tue, 26 Feb 2002 19:05:24 -0500
Date: Wed, 27 Feb 2002 01:08:21 +0100 (CET)
From: Alexander Newald <alexander@newald.de>
To: linux-kernel@vger.kernel.org
Subject: Docs for /proc for 2.4.17 or how to tune cacheing?
Message-ID: <Pine.LNX.4.40.0202270102460.6162-100000@hannover-internet.de>
Organization: www.hannover-internet.de
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have a linux box with 2.4.17 running and 512 MB ram.

While normal system running I have about 110 MB cache, 20 MB buffer, 150
mb free and the rest used mem.

As I have no tasks that will fork much or grow in size I think it would be
great to lower the size of free mem and rise the size of cache and buffer.

I undestand that this can be done with /proc/ and I looked in /proc/sys/vm
but only can see:

bdflush  kswapd  max-readahead  min-readahead  overcommit_memory
page-cluster  pagetable_cache

Here is the point I get stuck because I do not find any up to date docs
for /proc


Thanks for your time

Alexander Newald

