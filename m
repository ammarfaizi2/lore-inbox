Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286884AbRLWNnF>; Sun, 23 Dec 2001 08:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286888AbRLWNmz>; Sun, 23 Dec 2001 08:42:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:38823 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S286884AbRLWNmu>;
	Sun, 23 Dec 2001 08:42:50 -0500
Date: Sun, 23 Dec 2001 05:41:51 -0800 (PST)
Message-Id: <20011223.054151.99283627.davem@redhat.com>
To: sfr@gmx.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17rc1: KERNEL: assertion failed at tcp.c(1520):tcp_recvmsg
 ?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011223123320.GA1034@obelix.gallien.de>
In-Reply-To: <20011222.155713.84363957.davem@redhat.com>
	<20011223112953.GA7856@obelix.gallien.de>
	<20011223123320.GA1034@obelix.gallien.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stefan Frank <sfr@gmx.net>
   Date: Sun, 23 Dec 2001 13:33:20 +0100

   Any suggestions? I'm happy to provide more information if it helps.

Try a different compiler, the one you are using is known to generate
bogus kernels.
