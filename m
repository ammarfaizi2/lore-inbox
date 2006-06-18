Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWFRHLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWFRHLZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWFRHLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:11:25 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:31645 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751118AbWFRHLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:11:24 -0400
Date: Sun, 18 Jun 2006 09:06:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rt1
Message-ID: <20060618070641.GA6759@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5151]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.17-rt1 tree, which can be downloaded from the 
usual place:

   http://redhat.com/~mingo/realtime-preempt/

this is a fixes-only release: merged to 2.6.17-final and smaller fixes.

to build a 2.6.17-rc6-rt1 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.17.tar.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.17-rt1

	Ingo
