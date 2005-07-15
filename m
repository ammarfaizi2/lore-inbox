Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263302AbVGOOuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbVGOOuu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 10:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbVGOOut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 10:50:49 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:53201 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S263302AbVGOOuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 10:50:46 -0400
Date: Fri, 15 Jul 2005 16:50:24 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Christoph Hellwig <hch@infradead.org>
cc: Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Add security_task_post_setgid
In-Reply-To: <20050715143238.GA5759@infradead.org>
Message-ID: <Pine.LNX.4.61.0507151648590.29120@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0507142339570.3256@yvahk01.tjqt.qr>
 <20050714223807.GA25671@infradead.org> <Pine.LNX.4.61.0507150951150.20435@yvahk01.tjqt.qr>
 <20050715143238.GA5759@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>So keep the patch part of your module, it has no business in mainline
>so far.

And when is this becoming business? What made post_setUid go into the kernel?
