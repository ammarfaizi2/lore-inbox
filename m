Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751712AbWAKSJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbWAKSJb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWAKSJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:09:31 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:28073 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751711AbWAKSJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:09:30 -0500
Message-ID: <43C55BAF.180F3689@tv-sign.ru>
Date: Wed, 11 Jan 2006 22:25:35 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] rcu: fix hotplug-cpu ->donelist leak
References: <43C165BC.F7C6DCF5@tv-sign.ru> <20060109185944.GB15083@us.ibm.com> <43C2C818.65238C30@tv-sign.ru> <20060109195933.GE14738@us.ibm.com> <20060110095811.GA30159@in.ibm.com> <43C3C3B5.61D5641@tv-sign.ru> <20060111162809.GC21885@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" wrote:
> 
> This passed a ten-hour RCU torture test, with the torture test augmented

Thank you!

> by Vatsa's CPU-hotplug RCU-torture-test patch.

I can't find this patch, could you point me?

Oleg.
