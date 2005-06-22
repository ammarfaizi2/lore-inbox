Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVFVOjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVFVOjI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 10:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVFVOjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:39:07 -0400
Received: from opersys.com ([64.40.108.71]:27916 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261386AbVFVOid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:38:33 -0400
Subject: [ANNOUNCE] Linux RT Benchmarking Framework
From: Kristian Benoit <kbenoit@opersys.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 22 Jun 2005 10:33:46 -0400
Message-Id: <1119450826.5825.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As promised, we are finally releasing the Linux RealTime Benchmarking
Framework (LRTBF). We hope others will find it useful and even want
to add their own testsets. Generally we'll be more than pleased to add
contributions to future releases.

As was explained earlier, the Linux RT Benchmarking Framework (LRTBF)
is a set of drivers and scripts for evaluating the performance of
various real-time additions for the Linux kernel. Specifically, the
LRTBF allows measuring the overall load imposed by the RT enhancement
and its ability to deterministically respond to incoming interrupts.
Initially, the LRTBF was used for evaluating Ingo Molnar's PREEMPT_RT
patches and Philippe Gerum's I-pipe, but by releasing it under the
GPL we hope its usefullness will extend beyond those initial tests.

The LRTBF and all related information is found here:
http://www.opersys.com/lrtbf/

Enjoy !

Kristian Benoit
Karim Yaghmour
-- 
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || 1-866-677-4546

