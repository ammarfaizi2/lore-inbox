Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270154AbRIBXFm>; Sun, 2 Sep 2001 19:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270171AbRIBXFd>; Sun, 2 Sep 2001 19:05:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21638 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270154AbRIBXFZ>;
	Sun, 2 Sep 2001 19:05:25 -0400
Date: Sun, 02 Sep 2001 16:05:42 -0700 (PDT)
Message-Id: <20010902.160542.71088424.davem@redhat.com>
To: adam@yggdrasil.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci_alloc_consistent for small allocations?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200109021508.IAA29875@adam.yggdrasil.com>
In-Reply-To: <200109021508.IAA29875@adam.yggdrasil.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Read Documentation/DMA-mapping.txt and read about pci_pool.

I don't know why I bother documenting anything if people
don't even read it. :-)

Later,
David S. Miller
davem@redhat.com
