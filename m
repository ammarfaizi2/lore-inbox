Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVCWIsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVCWIsb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 03:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVCWIsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 03:48:31 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:32690 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261293AbVCWIs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 03:48:28 -0500
Date: Wed, 23 Mar 2005 09:48:18 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Yichen Xie <yxie@cs.stanford.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: memory leak in net/sched/ipt.c?
In-Reply-To: <Pine.LNX.4.61.0503230011090.4207@kaki.stanford.edu>
Message-ID: <Pine.LNX.4.61.0503230947300.12812@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503230011090.4207@kaki.stanford.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is the memory block allocated on line 315 leaked every time tcp_ipt_dump is
> called?

What kernel version?


Jan Engelhardt
-- 
