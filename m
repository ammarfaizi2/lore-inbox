Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270264AbRH1GCk>; Tue, 28 Aug 2001 02:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270269AbRH1GCa>; Tue, 28 Aug 2001 02:02:30 -0400
Received: from s210-181-87-28.thrunet.ne.kr ([210.181.87.28]:46853 "EHLO
	ns.formail.org") by vger.kernel.org with ESMTP id <S270266AbRH1GCO>;
	Tue, 28 Aug 2001 02:02:14 -0400
From: Kim Yong Il <nalabi@linuxkim.net>
Date: Tue, 28 Aug 2001 15:02:24 +0900
To: linux-kernel@vger.kernel.org
Subject: sysctl_wmem_max = 131071 
Message-ID: <20010828150224.A29538@formail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/usr/src/kernel-source-2.4.8/net/core/sock.c

635         sysctl_wmem_max = 131071;

How long value??

can change sysctl_wmem_max > 524284 ??

How can change??

