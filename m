Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVCKJ3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVCKJ3K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 04:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVCKJ3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 04:29:10 -0500
Received: from mx2.elte.hu ([157.181.151.9]:57297 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261410AbVCKJ3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 04:29:07 -0500
Date: Fri, 11 Mar 2005 10:28:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] Real-Time Preemption, -RT-2.6.11-final-V0.7.40-00
Message-ID: <20050311092847.GA17855@elte.hu>
References: <20050204100347.GA13186@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204100347.GA13186@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the -V0.7.40-00 Real-Time Preemption patch, which can be
downloaded from the usual place:

  http://redhat.com/~mingo/realtime-preempt/

this is a merge to 2.6.11-final.

to create a -V0.7.40-00 tree from scratch, the patching order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.11-final-V0.7.40-00

	Ingo
