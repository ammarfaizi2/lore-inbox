Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267007AbSKLV4R>; Tue, 12 Nov 2002 16:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267006AbSKLV4R>; Tue, 12 Nov 2002 16:56:17 -0500
Received: from pizda.ninka.net ([216.101.162.242]:62400 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267007AbSKLV4Q>;
	Tue, 12 Nov 2002 16:56:16 -0500
Date: Tue, 12 Nov 2002 14:01:20 -0800 (PST)
Message-Id: <20021112.140120.52304636.davem@redhat.com>
To: manfred@colorfullife.com
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] flush_cache_page while pte valid
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DD16A3A.8040108@colorfullife.com>
References: <3DD16A3A.8040108@colorfullife.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Manfred Spraul <manfred@colorfullife.com>
   Date: Tue, 12 Nov 2002 21:53:14 +0100

   The lost dirty bit can only happen on cpus where the hardware maintains 
   a dirty bit. I doubt that the sparc cpus do that in hardware.
   
sun4m sparc32 chips do, exactly like x86

Franks a lot,
David S. Miller
davem@redhat.com
