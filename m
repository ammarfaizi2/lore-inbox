Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbUKSTGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbUKSTGA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 14:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbUKSTGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 14:06:00 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.21]:14163 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261524AbUKSTF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 14:05:57 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041118164612.GA17040@elte.hu>
References: <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu>
	 <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
	 <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
	 <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
	 <20041118164612.GA17040@elte.hu>
Content-Type: text/plain
Date: Fri, 19 Nov 2004 20:05:56 +0100
Message-Id: <1100891156.6119.8.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

in 29-4 I get a lot of these lines in my log:

drivers/usb/input/hid-core.c: input irq status -71 received

29-0 didn't do that.

Kind regards,

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

