Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261614AbSI0DVa>; Thu, 26 Sep 2002 23:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbSI0DVa>; Thu, 26 Sep 2002 23:21:30 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:16575 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S261614AbSI0DV3>;
	Thu, 26 Sep 2002 23:21:29 -0400
Message-ID: <1033097205.3d93cff5703ac@kolivas.net>
Date: Fri, 27 Sep 2002 13:26:45 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] 2.4.20-pre8 contest results
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here are the contest (http://contest.kolivas.net) results for 2.4.20-pre8
compared to previous kernels.

noload:
Kernel                  Time            CPU             Ratio
2.4.19                  70.42           99%             1.00
2.4.20-pre7             70.37           99%             1.00
2.4.20-pre8             70.47           99%             1.00

process_load:
Kernel                  Time            CPU             Ratio
2.4.19                  85.21           80%             1.21
2.4.20-pre7             86.02           80%             1.22
2.4.20-pre8             86.65           80%             1.23

io_load:
Kernel                  Time            CPU             Ratio
2.4.19                  165.56          45%             2.35
2.4.20-pre7             195.32          38%             2.77
2.4.20-pre8             167.14          45%             2.37

mem_load:
Kernel                  Time            CPU             Ratio
2.4.19                  100.70          76%             1.43
2.4.20-pre7             102.83          75%             1.46
2.4.20-pre8             102.14          76%             1.45

There's no significant change since 2.4.19 which is what we'd expect.

Con.
