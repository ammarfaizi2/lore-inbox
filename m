Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264114AbTCXFdI>; Mon, 24 Mar 2003 00:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264117AbTCXFdI>; Mon, 24 Mar 2003 00:33:08 -0500
Received: from pizda.ninka.net ([216.101.162.242]:53705 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264114AbTCXFdH>;
	Mon, 24 Mar 2003 00:33:07 -0500
Date: Sun, 23 Mar 2003 21:41:47 -0800 (PST)
Message-Id: <20030323.214147.104238225.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: use ipv6_addr_any() for testing unspecified
 address
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030323.013535.60875023.yoshfuji@linux-ipv6.org>
References: <20030323.013535.60875023.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Sun, 23 Mar 2003 01:35:35 +0900 (JST)

   Use ipv6_addr_any() for testing unspecified address.

Applied, thank you.
