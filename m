Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751687AbWHSJjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWHSJjM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 05:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWHSJjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 05:39:12 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:35777 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751685AbWHSJjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 05:39:10 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.34-pre1 USB mass-storage burped...
Date: Sat, 19 Aug 2006 19:39:06 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <78mde2t57okmmnaeslpcen9884mu0v3epb@4ax.com>
References: <9aide2d3ano7v3853kgfhhpbgarmns4t2f@4ax.com> <20060819084724.GA2078@1wt.eu>
In-Reply-To: <20060819084724.GA2078@1wt.eu>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2006 10:47:24 +0200, Willy Tarreau <w@1wt.eu> wrote:

>Hi Grant,
>
>On Sat, Aug 19, 2006 at 06:41:50PM +1000, Grant Coady wrote:
...
>Have you tried building over USB HDD for another kernel (at least 2.4.33) ?

No.

>If not, could you give it a try please ? I would like to know if this problem
>could have been introduced by the locking changes in 2.4.34-pre1.

Okay, reboot into 2.4.33 and run just the USB HDD test for you, NFS seems 
okay after 4 hours or so.  I'll leave the USB HDD kernel rebuild running 
overnight then...

Grant.
