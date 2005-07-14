Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVGNUY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVGNUY2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVGNUWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:22:47 -0400
Received: from fmr23.intel.com ([143.183.121.15]:711 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261645AbVGNUV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:21:28 -0400
Message-Id: <200507142021.j6EKLPg04710@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Subject: [announce] linux kernel performance project launch at sourceforge.net
Date: Thu, 14 Jul 2005 13:21:25 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWIsZvEsks0gLpjRFuu0RnyvLbzGg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm pleased to announce that we have established a linux kernel
performance project, hosted at sourceforge.net:

http://kernel-perf.sourceforge.net

As much as discussed various time in the past on LKML that Linux
kernel needs a systematic and disciplined way to measure and track
kernel performance on a regular basis.  To do that, we decided to
run a large set of benchmarks covering core components of the Linux
kernel (virtual memory management, I/O subsystem, process scheduler,
file system, network, device driver, etc) on a regular basis.
Benchmarks are run on a variety of platforms (4P Intel Xeon processor,
2P Xeon, several ia64 server boxes etc) every week, measuring the
latest snapshot of Linus' git development tree. Comprehensive performance
data from our tests will be published for easy access.

Our goal is to work with the Linux community to further enhance the
performance of the Linux kernel. The data available on the site allows
community members to closely track performance gains and losses with
every version of the kernel. Ultimately, we hope that this data will
result in performance increases in Linux kernel development.

The benchmark result pages are populated with a few benchmarks at the
moment.  In the coming weeks, we will be populating more benchmark data.
Happy surfing and hacking!!


		Ken Chen <kenneth.w.chen@intel.com>
		Intel Open Source Technology Center

