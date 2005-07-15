Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVGOPG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVGOPG2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 11:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbVGOPG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 11:06:28 -0400
Received: from [212.76.86.54] ([212.76.86.54]:51204 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S261428AbVGOPG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 11:06:27 -0400
Message-Id: <200507151505.SAA00652@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Chen, Kenneth W'" <kenneth.w.chen@intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [announce] linux kernel performance project launch at sourceforge.net
Date: Fri, 15 Jul 2005 18:05:33 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <200507142021.j6EKLPg04710@unix-os.sc.intel.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcWIsZvEsks0gLpjRFuu0RnyvLbzGgAeKOsQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Chen <kenneth.w.chen@intel.com> wrote: {
...Linux kernel needs a systematic and disciplined way to measure and track
kernel performance on a regular basis.
}

Nice, but the numbers would have more meaning if they were put in relation
to System Load ( CPU,MEM,DISK,NET,... )

Also, a test that saturates resources would easily expose deeper Kernel
problems.

Thanks,
		Al

