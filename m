Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286885AbRLWNmp>; Sun, 23 Dec 2001 08:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286884AbRLWNmf>; Sun, 23 Dec 2001 08:42:35 -0500
Received: from pizda.ninka.net ([216.101.162.242]:37031 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S286885AbRLWNmZ>;
	Sun, 23 Dec 2001 08:42:25 -0500
Date: Sun, 23 Dec 2001 05:41:25 -0800 (PST)
Message-Id: <20011223.054125.24612280.davem@redhat.com>
To: sfr@gmx.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17rc1: KERNEL: assertion failed at tcp.c(1520):tcp_recvmsg
 ?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011223112953.GA7856@obelix.gallien.de>
In-Reply-To: <20011222083457.GA666@asterix>
	<20011222.155713.84363957.davem@redhat.com>
	<20011223112953.GA7856@obelix.gallien.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try with a different compiler, as others in this thread have noted the
compiler you are using is flakey at best.
