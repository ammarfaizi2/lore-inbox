Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWCTIxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWCTIxp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWCTIxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:53:45 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:59325 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932243AbWCTIxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:53:44 -0500
Date: Mon, 20 Mar 2006 09:51:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rt1
Message-ID: <20060320085137.GA29554@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.16-rt1 tree, which can be downloaded from the 
usual place:

   http://redhat.com/~mingo/realtime-preempt/

this is mostly a merge from -rc6 to 2.6.16-final, plus some smaller 
fixes.

to build a 2.6.16-rt1 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.16.tar.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.16-rt1

	Ingo
