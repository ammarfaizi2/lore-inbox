Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261431AbSJHTnV>; Tue, 8 Oct 2002 15:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261477AbSJHTm1>; Tue, 8 Oct 2002 15:42:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42662 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261328AbSJHTlu>;
	Tue, 8 Oct 2002 15:41:50 -0400
Date: Tue, 08 Oct 2002 12:40:02 -0700 (PDT)
Message-Id: <20021008.124002.06553598.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Fix Prefix Length of Link-local Addresses
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021008.093721.11469009.yoshfuji@linux-ipv6.org>
References: <20021008.000559.17528416.yoshfuji@linux-ipv6.org>
	<20021007.115530.00078126.davem@redhat.com>
	<20021008.093721.11469009.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Tue, 08 Oct 2002 09:37:21 +0900 (JST)

   So,... What kind of patches do you prefer, now?
   
    - on top of plain kernel (2.4.19, 2.4.20, 2.4.21-preXX, or whatever)
    - plain kernel + on top of our whole patch?
    - ???

If you send patches against 2.4.20-pre9, it would be fine.
