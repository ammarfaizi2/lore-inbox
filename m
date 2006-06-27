Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932667AbWF0KWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbWF0KWv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 06:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbWF0KWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 06:22:51 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:63410 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932667AbWF0KWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 06:22:50 -0400
Date: Tue, 27 Jun 2006 12:18:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rt3
Message-ID: <20060627101806.GA18095@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5297]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.17-rt3 tree, which can be downloaded from the 
usual place:

   http://redhat.com/~mingo/realtime-preempt/

this is a fixes-only release: NUMA fix, GTOD fix, MIPS fix.

to build a 2.6.17-rc6-rt3 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.17.tar.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.17-rt3

	Ingo
