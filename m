Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279009AbRJVWaV>; Mon, 22 Oct 2001 18:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279017AbRJVW2X>; Mon, 22 Oct 2001 18:28:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38785 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279015AbRJVW1d>;
	Mon, 22 Oct 2001 18:27:33 -0400
Date: Mon, 22 Oct 2001 15:28:00 -0700 (PDT)
Message-Id: <20011022.152800.59654230.davem@redhat.com>
To: sten@blinkenlights.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: INIT_MMAP on sparc64
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.40-blink.0110230030150.20416-100000@deepthought.blinkenlights.nl>
In-Reply-To: <20011021.181523.112610375.davem@redhat.com>
	<Pine.LNX.4.40-blink.0110230030150.20416-100000@deepthought.blinkenlights.nl>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Sten <sten@blinkenlights.nl>
   Date: Tue, 23 Oct 2001 00:39:35 +0200 (CEST)
   
   mjes, the kernel module loader is nice, it's just
   that I know what hardware I have and like to build
   a kernel with what I need.
   
"arch/sparc64/defconfig" handles every onboard necessary device any
machine in my sparc64 collection has, and that kernel is under 3.5MB

It probably encompasses all the hardware you really need too :-)

Franks a lot,
David S. Miller
davem@redhat.com



