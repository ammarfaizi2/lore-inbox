Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318520AbSHEPER>; Mon, 5 Aug 2002 11:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318526AbSHEPER>; Mon, 5 Aug 2002 11:04:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29635 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318520AbSHEPEQ>;
	Mon, 5 Aug 2002 11:04:16 -0400
Date: Mon, 05 Aug 2002 07:54:46 -0700 (PDT)
Message-Id: <20020805.075446.82337934.davem@redhat.com>
To: trond.myklebust@fys.uio.no
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Fragment flooding in 2.4.x/2.5.x
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15694.33047.965504.346909@charged.uio.no>
References: <200207011414.50465.trond.myklebust@fys.uio.no>
	<20020803.031740.84726417.davem@redhat.com>
	<15694.33047.965504.346909@charged.uio.no>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Trond Myklebust <trond.myklebust@fys.uio.no>
   Date: Mon, 5 Aug 2002 15:43:51 +0200
   
   Concerning the 2.4.x kernel: it would be very nice if this fix made it
   into 2.4.19, as the bug has already been known to crash a few
   servers...

I plan to push this to Marcelo if I haven't already done
so :-)
