Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268452AbTCCJBu>; Mon, 3 Mar 2003 04:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268454AbTCCJBu>; Mon, 3 Mar 2003 04:01:50 -0500
Received: from pizda.ninka.net ([216.101.162.242]:33191 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268452AbTCCJBt>;
	Mon, 3 Mar 2003 04:01:49 -0500
Date: Mon, 03 Mar 2003 00:54:28 -0800 (PST)
Message-Id: <20030303.005428.96142819.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Privacy Extensions for Stateless Address
 Autoconfiguration in IPv6
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030226.004155.71903869.yoshfuji@linux-ipv6.org>
References: <20021101.174832.44646503.yoshfuji@linux-ipv6.org>
	<20030223.223114.65976206.davem@redhat.com>
	<20030226.004155.71903869.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Wed, 26 Feb 2003 00:41:55 +0900 (JST)
   
   Well, I've found a bug that a temporary addresses were not
   re-generated properly.  Here's the patch for linux-2.5.63.

Fix applied, thanks.
