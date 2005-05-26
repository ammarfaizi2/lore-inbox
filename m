Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVEZHta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVEZHta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 03:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVEZHtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 03:49:13 -0400
Received: from mx2.elte.hu ([157.181.151.9]:28866 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261254AbVEZHqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 03:46:35 -0400
Date: Thu, 26 May 2005 09:35:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] Real-Time Preemption, -RT-2.6.12-rc5-V0.7.47-09
Message-ID: <20050526073559.GA3634@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the -V0.7.47-09 Real-Time Preemption patch, which can be 
downloaded from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

Changes:

 - merge to -rc5

 - small fixes

to build a -V0.7.47-09 tree, the following patches have to be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc5.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc5-V0.7.47-09

	Ingo
