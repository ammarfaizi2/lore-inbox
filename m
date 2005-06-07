Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVFGGHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVFGGHz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 02:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVFGGHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 02:07:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57274 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261798AbVFGGHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 02:07:50 -0400
Date: Tue, 7 Jun 2005 08:07:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-19
Message-ID: <20050607060713.GA6295@elte.hu>
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


i have released the -V0.7.47-19 Real-Time Preemption patch, which can be 
downloaded from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

this release is a merge to 2.6.12-rc6.

to build a -V0.7.47-19 tree, the following patches have to be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc6.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc6-V0.7.47-19

	Ingo
