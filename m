Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbTIOBSQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 21:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbTIOBSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 21:18:16 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:39042
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262407AbTIOBSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 21:18:15 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] tbench 8x  2.6.0-test5 v test5-mm1 
Date: Mon, 15 Sep 2003 11:26:12 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309151126.12580.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

8 x P3 700Mhz 

tbench 192

2.6.0-test5:	Throughput 224.949 MB/sec 192 procs
2.6.0-test5-mm1:	Throughput 329.827 MB/sec 192 procs

It seems the tbench likes the interactivity tweaks.

Con

