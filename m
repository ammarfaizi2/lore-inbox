Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317035AbSHTNEG>; Tue, 20 Aug 2002 09:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317056AbSHTNEG>; Tue, 20 Aug 2002 09:04:06 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:20731 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317035AbSHTNEG>; Tue, 20 Aug 2002 09:04:06 -0400
Subject: Re: [PATCH] (2/2) discontigmem support for i386 against 2.4.20pre4:
	 discontigmem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: gone@us.ibm.com
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <200208200303.g7K330g11718@w-gaughen.beaverton.ibm.com>
References: <200208200303.g7K330g11718@w-gaughen.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 Aug 2002 14:07:25 +0100
Message-Id: <1029848845.22982.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-20 at 04:03, Patricia Gaughen wrote:
> Assumptions made: 
> 
>         - that the first node has at least 900Mb of memory

Is that assumption made for non NUMA too ?

