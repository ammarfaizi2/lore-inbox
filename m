Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSCTQNY>; Wed, 20 Mar 2002 11:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311739AbSCTQNO>; Wed, 20 Mar 2002 11:13:14 -0500
Received: from [195.239.244.122] ([195.239.244.122]:23558 "EHLO mail.tibc.ru")
	by vger.kernel.org with ESMTP id <S311749AbSCTQNF>;
	Wed, 20 Mar 2002 11:13:05 -0500
Date: Wed, 20 Mar 2002 19:12:50 +0300
From: shura <shura@tibc.ru>
X-Mailer: The Bat! (v1.00 Build 1311) Registered to Andy Malyshev
Reply-To: shura <shura@tibc.ru>
Organization: TIBC
Message-ID: <17800.020320@tibc.ru>
To: linux-kernel@vger.kernel.org
Subject: kfree_skb on hard IRQ c019aa41
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What does it mean?
I'm testing computer with 3 3Com 905B,multiport Digi AccelePort Xp,
256 Mb ram ,red hat 7.1, kernel 2.4.17 (later try 2.4.8,2.4.10), during working i
receives this messages and see memory leakage, after ~4 hours system
stopping. Kernel assembled with support driver 3Com 905B, and iptables

