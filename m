Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282983AbRLVX6c>; Sat, 22 Dec 2001 18:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282998AbRLVX6X>; Sat, 22 Dec 2001 18:58:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:32161 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282983AbRLVX6G>;
	Sat, 22 Dec 2001 18:58:06 -0500
Date: Sat, 22 Dec 2001 15:57:13 -0800 (PST)
Message-Id: <20011222.155713.84363957.davem@redhat.com>
To: sfr@gmx.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17rc1: KERNEL: assertion failed at tcp.c(1520):tcp_recvmsg
 ?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011222083457.GA666@asterix>
In-Reply-To: <20011222083457.GA666@asterix>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What compiler are you using to build these kernels?  To be honest
the assertion you have triggered ought to be impossible and this is
the first report I've ever seen of it triggering.
