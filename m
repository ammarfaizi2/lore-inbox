Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbTATGZs>; Mon, 20 Jan 2003 01:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbTATGZs>; Mon, 20 Jan 2003 01:25:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23500 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261375AbTATGZr>;
	Mon, 20 Jan 2003 01:25:47 -0500
Date: Sun, 19 Jan 2003 22:24:19 -0800 (PST)
Message-Id: <20030119.222419.37433821.davem@redhat.com>
To: wli@holomorphy.com
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpumask_t
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030120063219.GL780@holomorphy.com>
References: <20030119213524.GH780@holomorphy.com>
	<20030119.221013.65242960.davem@redhat.com>
	<20030120063219.GL780@holomorphy.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: William Lee Irwin III <wli@holomorphy.com>
   Date: Sun, 19 Jan 2003 22:32:19 -0800

   I'll also attempt to get a SPARC toolchain together (as I understand it,
   there are some divergences from mainline/current gcc/binutils) and do
   some compiletesting-like and API conversion things there.

For sparc64 we use an old CVS egcs snapshot as that is the
only thing which builds reliable kernels, especially in 2.5.x
