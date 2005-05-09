Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263072AbVEIHh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbVEIHh3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 03:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbVEIHh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 03:37:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:28841 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263072AbVEIHh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 03:37:26 -0400
Date: Mon, 9 May 2005 09:37:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, dwalker@mvista.com
Subject: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-00
Message-ID: <20050509073702.GA13615@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the -V0.7.47-00 Real-Time Preemption patch, which can be 
downloaded from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

this patch reintroduces the plist.h code from Daniel Walker and Inaky 
Perez-Gonzalez. It's also a merge to 2.6.12-rc4.

to build a -V0.7.47-00 tree, the following patches have to be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc4.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc4-V0.7.47-00

	Ingo
