Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269020AbTBWXbf>; Sun, 23 Feb 2003 18:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269021AbTBWXbf>; Sun, 23 Feb 2003 18:31:35 -0500
Received: from franka.aracnet.com ([216.99.193.44]:51148 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269020AbTBWXbf>; Sun, 23 Feb 2003 18:31:35 -0500
Date: Sun, 23 Feb 2003 15:37:49 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Bill Davidsen <davidsen@tmr.com>, Ben Greear <greearb@candelatech.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <33350000.1046043468@[10.10.2.4]>
In-Reply-To: <Pine.LNX.3.96.1030223182350.999E-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1030223182350.999E-100000@gatekeeper.tmr.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> For instance, don't locks simply get compiled away to nothing on
>> uni-processor machines?
> 
> Preempt causes most of the issues of SMP with few of the benefits. There
> are loads for which it's ideal, but for general use it may not be the
> right feature, and I ran it during the time when it was just a patch, but
> lately I'm convinced it's for special occasions.

Note that preemption was pushed by the embedded people Larry was advocating
for, not the big-machine crowd .... ironic, eh?

M.

