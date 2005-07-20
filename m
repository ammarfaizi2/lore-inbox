Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVGTGSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVGTGSk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 02:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVGTGSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 02:18:39 -0400
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:53950 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261190AbVGTGS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 02:18:27 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Interbench v0.22 - Interactivity benchmark
Date: Wed, 20 Jul 2005 16:20:59 +1000
User-Agent: KMail/1.8.1
Cc: ck@vds.kolivas.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507201620.59346.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interbench is a benchmarking application designed to emulate the CPU 
scheduling behavior of interactive tasks and measure their scheduling latency 
and jitter. It does this first with the tasks on their own and then in the 
presence of various background loads.

Homepage:
http://interbench.kolivas.org/
Tar/BZ2:
http://ck.kolivas.org/apps/interbench/interbench-0.22.tar.bz2

Changes since v0.21:
Real time processes were converted to also do mlockall().
2.4 kernel support was added thanks to Miguel Freitas.
Some overflow accounting bugs were fixed.

Cheers,
Con
