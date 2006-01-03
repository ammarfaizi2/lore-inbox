Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWACJrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWACJrd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 04:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWACJrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 04:47:33 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:15525 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750831AbWACJrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 04:47:32 -0500
Date: Tue, 3 Jan 2006 10:47:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rt1
Message-ID: <20060103094720.GA16497@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.15-rt1 tree, which can be downloaded from the 
usual place:

   http://redhat.com/~mingo/realtime-preempt/

no big changes, this release is mainly a merge to v2.6.15, and should 
fix some of the RTC driver problems reported for 2.6.15-rc7-rt3.

to build a 2.6.15-rt1 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.15.tar.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.15-rt1

	Ingo
