Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264113AbTCXF2b>; Mon, 24 Mar 2003 00:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264114AbTCXF2b>; Mon, 24 Mar 2003 00:28:31 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49353 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264113AbTCXF2a>;
	Mon, 24 Mar 2003 00:28:30 -0500
Date: Sun, 23 Mar 2003 21:37:18 -0800 (PST)
Message-Id: <20030323.213718.83707259.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: use "const" qualifier
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030323.013528.19572208.yoshfuji@linux-ipv6.org>
References: <20030323.013528.19572208.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Sun, 23 Mar 2003 01:35:28 +0900 (JST)

   Specify some arguments of IPv6 address manipulation / testing functions
   "const" qualifier.
   
   Patch is against linux-2.5.64 + ChangeSet 1.1188.
   This should be suitable for linux-2.4.x.

Applied, thanks.
