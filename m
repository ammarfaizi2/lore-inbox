Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287838AbSAXNsK>; Thu, 24 Jan 2002 08:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287841AbSAXNsA>; Thu, 24 Jan 2002 08:48:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:30344 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S287838AbSAXNru>;
	Thu, 24 Jan 2002 08:47:50 -0500
Date: Thu, 24 Jan 2002 05:46:26 -0800 (PST)
Message-Id: <20020124.054626.15688749.davem@redhat.com>
To: jes@wildopensource.com
Cc: adam@yggdrasil.com, linux-acenic@sunsite.dk, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.3-pre4/drivers/acenic.c: pci_unmap_addr_set not
 defined for x86
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15440.4044.565375.681853@trained-monkey.org>
In-Reply-To: <200201241001.CAA00304@baldur.yggdrasil.com>
	<15440.4044.565375.681853@trained-monkey.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jes Sorensen <jes@wildopensource.com>
   Date: Thu, 24 Jan 2002 08:44:44 -0500
   
   I haven't had a chance to look at it yet. The patch wasn't done by me
   and whoever submitted it didn't seem to think it was worth the effort of
   Cc'ing me a copy of it ;-(

I was changing APIs, do I have to CC: every driver author on the
planet when I do this?
