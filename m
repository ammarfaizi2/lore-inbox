Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268562AbTCCJh0>; Mon, 3 Mar 2003 04:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268560AbTCCJhZ>; Mon, 3 Mar 2003 04:37:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:58791 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268557AbTCCJhZ>;
	Mon, 3 Mar 2003 04:37:25 -0500
Date: Mon, 03 Mar 2003 01:30:13 -0800 (PST)
Message-Id: <20030303.013013.93812658.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] Use C99 initializers in net/ipv6
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030228.065944.08980219.yoshfuji@linux-ipv6.org>
References: <20030228.065944.08980219.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Fri, 28 Feb 2003 06:59:44 +0900 (JST)

   This convers net/ipv6/{addrconf,route,sit}.c files to use C99
   initializers.  We don't touch net/ipv6/exthdrs.c for now because
   it will conflicts with our patch for IPsec.

Applied, thanks.
