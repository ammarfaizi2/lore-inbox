Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUG3B1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUG3B1D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 21:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267558AbUG3B1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 21:27:03 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:7950 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S267555AbUG3B1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 21:27:00 -0400
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, aebr@win.tue.nl, vojtech@suse.cz,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
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
	<20040729162423.7452e8f5.akpm@osdl.org>
	<20040729165152.492faced.pj@sgi.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 30 Jul 2004 10:25:56 +0900
In-Reply-To: <20040729165152.492faced.pj@sgi.com>
Message-ID: <87pt6e2sm3.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

> Don't wait on me ... as indicated in my last post on this lkml thread,
> I left this back in the hands of the expert, OGAWA Hirofumi.

Could you please post your lastest patch? It seems that my patch does
not satisfy peoples.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
