Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVDEHW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVDEHW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 03:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVDEHV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:21:26 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64161 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261592AbVDEHTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:19:20 -0400
Date: Tue, 5 Apr 2005 09:19:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: [patch] Real-Time Preemption, -RT-2.6.12-rc2-V0.7.44-00
Message-ID: <20050405071911.GA23653@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu> <20050401104724.GA31971@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050401104724.GA31971@elte.hu>
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


i have released the -V0.7.44-00 Real-Time Preemption patch, which can be 
downloaded from the usual place:

   http://redhat.com/~mingo/realtime-preempt/

this is a merge of -43-08 to 2.6.12-rc2.

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc2.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc2-V0.7.44-00

	Ingo
