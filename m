Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbULYLcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbULYLcg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 06:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbULYLcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 06:32:36 -0500
Received: from [202.141.25.89] ([202.141.25.89]:60853 "EHLO
	pridns.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261500AbULYLce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 06:32:34 -0500
Subject: Trying out SCHED_BATCH 
From: Rajsekar <raj--cutme--sekar@cse.iDELTHISitm.ernet.in>
To: linux-kernel@vger.kernel.org
Date: Sat, 25 Dec 2004 17:01:29 +0530
Message-ID: <m3mzw262cu.fsf@rajsekar.pc>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would like to try out the SCHED_BATCH.  Unfortunately, I am not able to
find a patch for my kernel.  Could someone enlighten me on this?

I am running 2.6.10-rc1-mm2 with staircase scheduler patch.  My `uname -a'
output is:

Linux rajsekar.pc 2.6.10-rc1-mm2staircase #2 Sat Dec 4 10:49:31 IST 2004 i686 AuthenticAMD unknown GNU/Linux

-- 
    Rajsekar

