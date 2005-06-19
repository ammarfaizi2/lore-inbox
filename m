Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVFSNou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVFSNou (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 09:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVFSNot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 09:44:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64390 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261831AbVFSNos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 09:44:48 -0400
Date: Sun, 19 Jun 2005 15:44:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] Real-Time Preemption, -RT-2.6.12-V0.7.49-00
Message-ID: <20050619134400.GA19795@elte.hu>
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


i have released the -V0.7.49-00 Real-Time Preemption patch, which can be 
downloaded from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

this is mostly a merge to 2.6.12-final.

to build a -V0.7.49-00 tree, the following patches should to be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-final-V0.7.49-00

	Ingo
