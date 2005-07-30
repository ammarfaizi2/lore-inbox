Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262995AbVG3QDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262995AbVG3QDr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 12:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbVG3QDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 12:03:46 -0400
Received: from mx1.elte.hu ([157.181.1.137]:59846 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262995AbVG3QDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 12:03:41 -0400
Date: Sat, 30 Jul 2005 18:03:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
Message-ID: <20050730160345.GA3584@elte.hu>
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


i have released the -V0.7.52-01 Real-Time Preemption patch, which can be 
downloaded from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

this release is mainly a merge to 2.6.13-rc4. (That merge slashed ~30K 
off the patch, due to the continuing merge of various bits of the -RT 
tree to mainline.)

to build a -V0.7.52-01 tree, the following patches should to be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.13-rc4.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.13-rc4-RT-V0.7.52-01

reports, patches, suggestions welcome.

	Ingo
