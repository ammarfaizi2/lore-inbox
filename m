Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbSKTV37>; Wed, 20 Nov 2002 16:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSKTV37>; Wed, 20 Nov 2002 16:29:59 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:13188 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262708AbSKTV36>; Wed, 20 Nov 2002 16:29:58 -0500
Subject: Re: [REPOST][PATCH] Fixup pci_alloc_consistent with 64bit DMA masks
	on i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steffen Persvold <sp@scali.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.44.0211202221160.15336-200000@sp-laptop.isdn.scali.no>
References: <Pine.LNX.4.44.0211202221160.15336-200000@sp-laptop.isdn.scali.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 22:05:35 +0000
Message-Id: <1037829935.3702.91.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its been in -ac for ages, its clearly a fix

