Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319027AbSIJARp>; Mon, 9 Sep 2002 20:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319029AbSIJARp>; Mon, 9 Sep 2002 20:17:45 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:15118
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319027AbSIJARk>; Mon, 9 Sep 2002 20:17:40 -0400
Subject: [patch] 2.4: updated preemptable kernel
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: kpreempt-tech@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Sep 2002 20:22:30 -0400
Message-Id: <1031617351.949.6.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated fully preemptive kernel patches are available at:

	2.4.19: http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.19-2.patch
	2.4.20-pre5: http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.20-pre5-1.patch
	2.4.20-pre5-ac4: http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.20-pre5-ac4-1.patch

and your favorite mirrors.

These releases contain some of the recent fixes from 2.5.  Note new
design features of kernel preemption will most likely not be back-ported
from 2.5; just fixes to the existing infrastructure.

The above patches include fixes for the "preempting with interrupts
disabled" bug as well as some other misc. issues.  Note they are not per
se in sync with 2.5 or each other yet...

Enjoy,

	Robert Love

