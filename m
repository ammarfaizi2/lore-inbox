Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265514AbSJSFid>; Sat, 19 Oct 2002 01:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbSJSFid>; Sat, 19 Oct 2002 01:38:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4047 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265514AbSJSFic>;
	Sat, 19 Oct 2002 01:38:32 -0400
Date: Fri, 18 Oct 2002 22:36:52 -0700 (PDT)
Message-Id: <20021018.223652.16894430.davem@redhat.com>
To: skip.ford@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44 net/ipv4/raw.c NF_IP_LOCAL_OUT undefined
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200210190459.g9J4x8vk008923@pool-141-150-241-241.delv.east.verizon.net>
References: <200210190459.g9J4x8vk008923@pool-141-150-241-241.delv.east.verizon.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Skip Ford <skip.ford@verizon.net>
   Date: Sat, 19 Oct 2002 00:59:08 -0400

   net/ipv4/raw.c needs to include netfilter_ipv4.h instead of just
   netfilter.h

Thanks for the fix, applied.
