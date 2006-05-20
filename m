Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWETR4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWETR4F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 13:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWETR4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 13:56:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:711 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751467AbWETR4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 13:56:03 -0400
Date: Sat, 20 May 2006 10:55:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] net driver updates
Message-Id: <20060520105547.220f2bea.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605201035510.10823@g5.osdl.org>
References: <20060520042856.GA7218@havoc.gtf.org>
	<20060520092033.7d404315.akpm@osdl.org>
	<Pine.LNX.4.64.0605201035510.10823@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Sat, 20 May 2006, Andrew Morton wrote:
> > Jeff Garzik <jeff@garzik.org> wrote:
> > >
> > > Andrew Morton:
> > >        revert "forcedeth: fix multi irq issues"
> > 
> > Manfred just found the fix for this, so we should no longer need to revert.
> 
> Hmm. I already pulled. I guess we can revert the revert and apply 
> Manfreds fix. Jeff?
> 

I can cook up the necessary pieces.
