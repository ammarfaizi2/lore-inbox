Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265443AbSJSBLp>; Fri, 18 Oct 2002 21:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265444AbSJSBLp>; Fri, 18 Oct 2002 21:11:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37068 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265443AbSJSBLO>;
	Fri, 18 Oct 2002 21:11:14 -0400
Date: Fri, 18 Oct 2002 18:09:33 -0700 (PDT)
Message-Id: <20021018.180933.80085592.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Source Address of MLD Message
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021018.125215.922751890.yoshfuji@linux-ipv6.org>
References: <20021018.125215.922751890.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Fri, 18 Oct 2002 12:52:15 +0900 (JST)

   draft-ietf-magma-mld-source-02.txt clarifies that the source address of
   MLD Report / Done Message MUST be unspecified address when a link-local
   address is not available.  This patch follows this clarification.
   
   This patch is against 2.4.20-pre10.

Patch is applied, thanks.
