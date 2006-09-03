Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWICNUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWICNUh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 09:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWICNUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 09:20:37 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:6871 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751066AbWICNUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 09:20:36 -0400
From: Grant Coady <g_r_a_n_t_@dodo.com.au>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Grant Coady <gcoady.lk@gmail.com>
Subject: Re: [RFC/PATCH-mm] i8042: activate panic blink only in X
Date: Sun, 03 Sep 2006 23:20:30 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <9gllf2l6mgc6oatnni3c0l694dg15c0oli@4ax.com>
References: <200609022320.36754.dtor@insightbb.com>
In-Reply-To: <200609022320.36754.dtor@insightbb.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Sep 2006 23:20:36 -0400, Dmitry Torokhov <dtor@insightbb.com> wrote:

>To: LKML <linux-kernel@vger.kernel.org>
>Subject: [RFC/PATCH-mm] i8042: activate panic blink only in X
>From: Dmitry Torokhov <dtor@insightbb.com>
>Date: Sat, 2 Sep 2006 23:20:36 -0400
>Cc: Andrew Morton <akpm@osdl.org>, Grant Coady <gcoady.lk@gmail.com>
>
>Hi,
>
>Here is an attempt to make panicblink only active in X so there is a
>chance of keyboard still working after panic in text console. Any reason
>why is should not be done this way?
>

Works as expected here on console, I cannot test the X function.

Grant.

-- 
VGER BF report: U 0.480126
