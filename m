Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263956AbTDDTUt (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 14:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263957AbTDDTUt (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 14:20:49 -0500
Received: from enigma.lanl.gov ([128.165.250.185]:28291 "EHLO enigma.lanl.gov")
	by vger.kernel.org with ESMTP id S263956AbTDDTUs (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 14:20:48 -0500
Date: Fri, 4 Apr 2003 12:32:18 -0700
From: Erik Hendriks <hendriks@lanl.gov>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Syscall numbers for BProc
Message-ID: <20030404193218.GD15620@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to get a Linux system call number allocated for BProc?
(http://sourceforge.net/projects/bproc) I've been using arbitrary
system call numbers for a while but there have been collisions with
new kernel features.  I'd like to avoid that in the future.  BProc
currently works on 2.4.x kernels on x86, alpha and ppc (32bit).

Thanks,

- Erik
