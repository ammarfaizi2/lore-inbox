Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269776AbUICUQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269776AbUICUQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 16:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269754AbUICUOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 16:14:22 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:39587
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269770AbUICUJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 16:09:38 -0400
Date: Fri, 3 Sep 2004 13:08:17 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Paul Larson <plars@linuxtestproject.org>
Cc: brian.somers@sun.com, Michael.Waychison@sun.com,
       linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
Message-Id: <20040903130817.44b21383.davem@davemloft.net>
In-Reply-To: <1094238777.9913.278.camel@plars.austin.ibm.com>
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	<200408162049.FFF09413.8592816B@anet.ne.jp>
	<20040816143824.15238e42.davem@redhat.com>
	<412CD101.4050406@sun.com>
	<20040825120831.55a20c57.davem@redhat.com>
	<412CF0E9.2010903@sun.com>
	<20040825175805.6807014c.davem@redhat.com>
	<412DC055.4070401@sun.com>
	<20040830161126.585a6b62.davem@davemloft.net>
	<1094238777.9913.278.camel@plars.austin.ibm.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Sep 2004 14:12:58 -0500
Paul Larson <plars@linuxtestproject.org> wrote:

> I tried this patch alone on top of 2.6.9-rc1 and tg3 is still broken for
> me on JS20 blades.  Was there another patch I should have applied in
> conjunction with this?

Use current 2.6.9 which has all of the updates.
The driver should be version 3.9
