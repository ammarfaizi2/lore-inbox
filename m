Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271720AbTHHRTs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 13:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271715AbTHHRTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 13:19:44 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:12425 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271702AbTHHRTm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 13:19:42 -0400
Subject: Re: page_alloc.c bug and heavy I/O
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Xiaogang Wang <xiaogang.wang@umontreal.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SGI.4.44.0308081020540.107825-100000@esirch2.ESI.UMontreal.CA>
References: <Pine.SGI.4.44.0308081020540.107825-100000@esirch2.ESI.UMontreal.CA>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060362957.4933.51.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Aug 2003 18:15:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-08-08 at 15:39, Xiaogang Wang wrote:
> Hi,
> 
> My hardware and softare:
> 
>   Asus P4P800, 2GB memory, 2.8GHZ P4 with HT enabled.
>   On-board 3com Giga bit network card
>   1 parallel ata 160G maxtor disk
>   Nvidia Gefore4 MX440-8x graphics card (Asus V9180)
> 
>   Redhat 7.3, original kernel 2.4.18-3

How about updating to the errata kernel ?

