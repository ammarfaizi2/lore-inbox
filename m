Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317260AbSGXNWS>; Wed, 24 Jul 2002 09:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317184AbSGXNVg>; Wed, 24 Jul 2002 09:21:36 -0400
Received: from [210.78.134.243] ([210.78.134.243]:16394 "EHLO 210.78.134.243")
	by vger.kernel.org with ESMTP id <S317180AbSGXNUC>;
	Wed, 24 Jul 2002 09:20:02 -0400
Date: Wed, 24 Jul 2002 21:24:56 +0800
From: zhengchuanbo <zhengcb@netpower.com.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: about the performance of netfilter
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200207242128878.SM00796@zhengcb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


we use a linux router. i just tested the performance of the router. when the kernel  is build without netfilter support,the throughput of 64bytes frame is about 45%. when i build the kernel with netfilter (only the ip_filter module),the throughput dropped to 24%, without any rules.
so is there some way to improve the performance? i just want some simple packet filter. is netfilter no so good on the performance compare to ipchains due to the improved functionality?
please cc.  thanks.

regards,

zheng chuanbo
zhengcb@netpower.com.cn

