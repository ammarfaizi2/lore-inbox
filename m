Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279033AbRJVWmk>; Mon, 22 Oct 2001 18:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279029AbRJVWmc>; Mon, 22 Oct 2001 18:42:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48513 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279034AbRJVWjQ>;
	Mon, 22 Oct 2001 18:39:16 -0400
Date: Mon, 22 Oct 2001 15:39:47 -0700 (PDT)
Message-Id: <20011022.153947.48529984.davem@redhat.com>
To: sten@blinkenlights.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: INIT_MMAP on sparc64
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.40-blink.0110230044400.20416-100000@deepthought.blinkenlights.nl>
In-Reply-To: <20011022.152800.59654230.davem@redhat.com>
	<Pine.LNX.4.40-blink.0110230044400.20416-100000@deepthought.blinkenlights.nl>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Sten <sten@blinkenlights.nl>
   Date: Tue, 23 Oct 2001 00:50:42 +0200 (CEST)

   Well the thing is that I like todo evil things,
   like connecting sgi flatpanels to creator3d's, using
   non sun blessed ( aka sub 1000$ ) ethernet cards or
   sticking in wierd raid cards.
   
   Which is why I like linux ;)
   
   Having source is great because I can break it,
   and maybe learn something in the process.

All of this is irrelevant to going over the 3.5MB mark,
I contend that your machine simply does not need it no matter
what obscure stuff you stick into it :-)

Turn off the PCI device names, that is usually what eats up a
lot of space and lspci provides the same info anyways...

Franks a lot,
David S. Miller
davem@redhat.com
