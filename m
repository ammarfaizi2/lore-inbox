Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbUDDU6s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 16:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbUDDU6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 16:58:48 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:45745
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262788AbUDDU6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 16:58:47 -0400
Date: Sun, 4 Apr 2004 22:58:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-aa2
Message-ID: <20040404205848.GL482@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-aa2.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-aa2/

Changelog diff between 2.6.5-aa1 and 2.6.5-aa2:

Files 2.6.5-aa1/anon-vma.gz and 2.6.5-aa2/anon-vma.gz differ

	Merged Hugh Dickins's several fixes for non-x86/x86-64 archs.

Files 2.6.5-aa1/extraversion and 2.6.5-aa2/extraversion differ

	Rediffed.

Files 2.6.5-aa1/mprotect-vma-merging and 2.6.5-aa2/mprotect-vma-merging differ

	Microsmpscalabilityoptimization, take anon_vma_lock after
	__vma_modify(prev..).

Only in 2.6.5-aa2: xfs-vmtruncate

	Fix truncate to drop the mappings before removing the page from
	pagecache (should fix the WARN_ON). From Nathan Scott.
