Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264608AbSJNJxz>; Mon, 14 Oct 2002 05:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbSJNJxz>; Mon, 14 Oct 2002 05:53:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37527 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264608AbSJNJxy>;
	Mon, 14 Oct 2002 05:53:54 -0400
Date: Mon, 14 Oct 2002 02:52:50 -0700 (PDT)
Message-Id: <20021014.025250.105171520.davem@redhat.com>
To: raul@pleyades.net
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] mmap.c (do_mmap_pgoff), against 2.4.19 and 2.4.20-pre10
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021014093622.GA96@DervishD>
References: <20021014093622.GA96@DervishD>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: DervishD <raul@pleyades.net>
   Date: Mon, 14 Oct 2002 11:36:22 +0200

       This is the fourth and last time I submit this patch to Marcelo.
   This little tiny bug is fixed in all trees except the official one. I
   think this patch is trivial enough to be accepted, but...
   
Patches tend to get accepted when you attach an analysis
of the bug you are fixing.

I cannot even figure out what the failure case is that you are
fixing which actually occurs.

I bet if you explain this, Marcelo will take your fix.
