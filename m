Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVDUIa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVDUIa7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVDUIaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 04:30:16 -0400
Received: from mx1.elte.hu ([157.181.1.137]:31873 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261466AbVDUHfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:35:44 -0400
Date: Thu, 21 Apr 2005 09:35:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Daniel Walker <dwalker@mvista.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-00
Message-ID: <20050421073537.GA1004@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu> <20050401104724.GA31971@elte.hu> <20050405071911.GA23653@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405071911.GA23653@elte.hu>
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


i have released the -V0.7.46-00 Real-Time Preemption patch, which can be 
downloaded from the usual place:

   http://redhat.com/~mingo/realtime-preempt/

this is a merge to 2.6.12-rc3, plus the 'ping localhost' fix from 
yang.yi@bmrtech.com.

there are still some unsolved slowdowns probably related to the recent 
plist.h changes.

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc3.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc3-V0.7.46-00

	Ingo
