Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263970AbUCZIUQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 03:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263967AbUCZIUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 03:20:15 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:43428
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263970AbUCZIUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 03:20:08 -0500
Date: Fri, 26 Mar 2004 09:21:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc2-aa4
Message-ID: <20040326082100.GB9604@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup an hugetlbfs prio-tree truncate bug.

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc2-aa4.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc2-aa4/

Files 2.6.5-rc2-aa3/extraversion and 2.6.5-rc2-aa4/extraversion differ

	Rediffed.

Files 2.6.5-rc2-aa3/prio-tree.gz and 2.6.5-rc2-aa4/prio-tree.gz differ

	Avoid missing vmas starting at pg_off > truncate offset in
	hugetlbfs truncate. From Rajesh Venkatasubramanian.
