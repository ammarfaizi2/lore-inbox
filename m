Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261431AbSJMFnQ>; Sun, 13 Oct 2002 01:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261432AbSJMFnQ>; Sun, 13 Oct 2002 01:43:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55179 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261431AbSJMFnP>;
	Sun, 13 Oct 2002 01:43:15 -0400
Date: Sat, 12 Oct 2002 22:42:12 -0700 (PDT)
Message-Id: <20021012.224212.56861427.davem@redhat.com>
To: skraw@ithnet.com
Cc: ahu@ds9a.nl, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] USAGI IPsec
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021012140644.0d403b2c.skraw@ithnet.com>
References: <20021012111759.GA10104@outpost.ds9a.nl>
	<20021012.044137.42774593.davem@redhat.com>
	<20021012140644.0d403b2c.skraw@ithnet.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephan von Krawczynski <skraw@ithnet.com>
   Date: Sat, 12 Oct 2002 14:06:44 +0200

   This was a 2.2.19 kernel with equal-cost-multipath enabled
   and large routing-tables enabled.

It doesn't surprise me that 2.2.x performs like crap under
any real load btw :-)  It has none of the 2.3.x scalability
and threading work.
