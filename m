Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbTBXHZM>; Mon, 24 Feb 2003 02:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261205AbTBXHZL>; Mon, 24 Feb 2003 02:25:11 -0500
Received: from pizda.ninka.net ([216.101.162.242]:15332 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261518AbTBXHZB>;
	Mon, 24 Feb 2003 02:25:01 -0500
Date: Sun, 23 Feb 2003 23:18:47 -0800 (PST)
Message-Id: <20030223.231847.58640988.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, kuznet@ms2.inr.ac.ru,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Functions Clean-up
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030224.162911.826686204.yoshfuji@linux-ipv6.org>
References: <20030223.225426.28829614.davem@redhat.com>
	<20030224.161815.511623971.yoshfuji@linux-ipv6.org>
	<20030224.162911.826686204.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Mon, 24 Feb 2003 16:29:11 +0900 (JST)

   In article <20030224.161815.511623971.yoshfuji@linux-ipv6.org> (at Mon, 24 Feb 2003 16:18:15 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:
   
   > sorry, I had compiled with wrong options... :-p
   > just a moment, please...
   
   Please apply this patch on top of the previous patch.
   Sorry for the mess.

As I said, I fixed it already by using pfx->s6_addr.

No problems and no need to apologize :)
