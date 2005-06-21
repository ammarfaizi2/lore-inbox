Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVFULsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVFULsI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVFUL3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:29:54 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:43427 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261232AbVFULVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 07:21:04 -0400
Subject: Re: [PATCH] kdump documentation update to introduce use of irqpoll
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: vgoyal@in.ibm.com, ebiederm@xmission.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot@lists.osdl.org
In-Reply-To: <20050621023701.219705a4.akpm@osdl.org>
References: <20050621092613.GF3746@in.ibm.com>
	 <20050621023701.219705a4.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119352685.3279.107.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Jun 2005 12:18:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-06-21 at 10:37, Andrew Morton wrote:
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> >
> > o Specify "irqpoll" command line option which loading second kernel. This
> >    helps in reducing driver initialization failures in second kernel due
> >    to shared interrupts.
> 
> Well that rather assumes we've merged the irqpoll patch.
> 
> Is Alan OK with that?

I am fine with irqpoll merges. I think it's been adequately tested now.

