Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271733AbRHQWPo>; Fri, 17 Aug 2001 18:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271738AbRHQWP1>; Fri, 17 Aug 2001 18:15:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46208 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271733AbRHQWPX>;
	Fri, 17 Aug 2001 18:15:23 -0400
Date: Fri, 17 Aug 2001 15:15:25 -0700 (PDT)
Message-Id: <20010817.151525.59654778.davem@redhat.com>
To: alex.buell@tahallah.demon.co.uk
Cc: andre.dahlqvist@telia.com, linux-kernel@vger.kernel.org
Subject: Re: 'make dep' produces lots of errors with this .config
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0108172305530.9362-100000@tahallah.demon.co.uk>
In-Reply-To: <20010817234626.A29467@telia.com>
	<Pine.LNX.4.33.0108172305530.9362-100000@tahallah.demon.co.uk>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alex Buell <alex.buell@tahallah.demon.co.uk>
   Date: Fri, 17 Aug 2001 23:11:42 +0100 (BST)

   Dear Gods, not another of Linus's "holiday presents".  These are for the
   Sparc32 port, I came across one earlier and here's a slightly modified
   patch for drivers/char/vt.c. Original patch came from a l-lk post earlier
   (must have missed it, found a reference to it on sparclinux)

This is not a fix at all.

This build error can be solved in a sparc specific way.

In FACT we would even want this code on Sparc32 in certain
configurations.

Later,
David S. Miller
davem@redhat.com
