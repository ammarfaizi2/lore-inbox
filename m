Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268174AbTBXGcM>; Mon, 24 Feb 2003 01:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268175AbTBXGcM>; Mon, 24 Feb 2003 01:32:12 -0500
Received: from pizda.ninka.net ([216.101.162.242]:53987 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268174AbTBXGcL>;
	Mon, 24 Feb 2003 01:32:11 -0500
Date: Sun, 23 Feb 2003 22:25:57 -0800 (PST)
Message-Id: <20030223.222557.132586554.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, kuznet@ms2.inr.ac.ru,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Functions Clean-up
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030224.125702.13403857.yoshfuji@linux-ipv6.org>
References: <20021103.115427.104445233.yoshfuji@linux-ipv6.org>
	<20030223.011816.108201183.davem@redhat.com>
	<20030224.125702.13403857.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Mon, 24 Feb 2003 12:57:02 +0900 (JST)

   > I will apply this patch once you make the change.  Would you
   > like me to add it to 2.4.x as well?
   
   yes.  Do I need to send a patch for linux-2.4.xx, too?
   
Not necessary, I know what is different in the networking
between these two trees.
   
   Here's the patch for linux-2.5.62.

Applied, thanks.
