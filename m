Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUG2XWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUG2XWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 19:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267467AbUG2XWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 19:22:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:51627 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262906AbUG2XWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 19:22:34 -0400
Date: Thu, 29 Jul 2004 16:24:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: hirofumi@mail.parknet.co.jp, aebr@win.tue.nl, vojtech@suse.cz,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
Message-Id: <20040729162423.7452e8f5.akpm@osdl.org>
In-Reply-To: <20040729024931.4b4e78e6.pj@sgi.com>
References: <87llhjlxjk.fsf@devron.myhome.or.jp>
	<20040716164435.GA8078@ucw.cz>
	<20040716201523.GC5518@pclin040.win.tue.nl>
	<871xjbkv8g.fsf@devron.myhome.or.jp>
	<20040728115130.GA4008@pclin040.win.tue.nl>
	<87fz7c9j0y.fsf@devron.myhome.or.jp>
	<20040728134202.5938b275.pj@sgi.com>
	<87llh3ihcn.fsf@ibmpc.myhome.or.jp>
	<20040728231548.4edebd5b.pj@sgi.com>
	<87oelzjhcx.fsf@ibmpc.myhome.or.jp>
	<20040729024931.4b4e78e6.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hate to be a bore, but I'm still waiting for a definitive patch ;)
