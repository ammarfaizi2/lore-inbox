Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291474AbSBMJiO>; Wed, 13 Feb 2002 04:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291472AbSBMJiF>; Wed, 13 Feb 2002 04:38:05 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63616 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291463AbSBMJhq>;
	Wed, 13 Feb 2002 04:37:46 -0500
Date: Wed, 13 Feb 2002 01:35:57 -0800 (PST)
Message-Id: <20020213.013557.74564240.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org, ralf@uni-koblenz.de
Subject: Re: [patch] printk and dma_addr_t
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16avu8-0004lh-00@the-village.bc.nu>
In-Reply-To: <3C6A2FCA.C4F49062@zip.com.au>
	<E16avu8-0004lh-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Wed, 13 Feb 2002 09:40:44 +0000 (GMT)

   Vomit. How about adding a dma_addr_t %code to the printk function ?

And gcc will discover this via what?  Osmosis perhaps? :-)
