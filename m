Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbSJIX0J>; Wed, 9 Oct 2002 19:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263242AbSJIX0J>; Wed, 9 Oct 2002 19:26:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50868 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262937AbSJIX0J>;
	Wed, 9 Oct 2002 19:26:09 -0400
Date: Wed, 09 Oct 2002 16:24:38 -0700 (PDT)
Message-Id: <20021009.162438.82081593.davem@redhat.com>
To: dfawcus@cisco.com
Cc: sekiya@sfc.wide.ad.jp, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Fix Prefix Length of Link-local Addresses
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021010002902.A3803@edi-view1.cisco.com>
References: <20021009234421.J29133@edinburgh.cisco.com>
	<20021009.161414.63434223.davem@redhat.com>
	<20021010002902.A3803@edi-view1.cisco.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Derek Fawcus <dfawcus@cisco.com>
   Date: Thu, 10 Oct 2002 00:29:02 +0100

   There are areas where the TAHI tests expect a certain behaviour
   when more than one behaviour is acceptable.

Great, that's what I was trying to find out.

Now I just need to know if this link-local prefix case
is one such issue. :-)

