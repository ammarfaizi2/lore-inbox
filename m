Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSHFWwW>; Tue, 6 Aug 2002 18:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSHFWvj>; Tue, 6 Aug 2002 18:51:39 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:50677 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316408AbSHFWvU>; Tue, 6 Aug 2002 18:51:20 -0400
Subject: Re: intel chipsets not recognized in 2.4.19
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Walter A. Boring IV" <wboring@qualys.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1028673358.2551.4.camel@hemna.qualys.com>
References: <1028673358.2551.4.camel@hemna.qualys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 01:14:12 +0100
Message-Id: <1028679252.18156.222.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-06 at 23:35, Walter A. Boring IV wrote:
> Howdy, 
>   I just compiled/installed 2.4.19 on my new Dell box.
> I can't seem to enable dma on it due to the kernel not detecting the IDE
> chipset correctly, as you can see from the lspci dump below.

>  Any ideas how to hack around this so I can get dma running?

2.4.19-ac4 will do the job. And hopefully 2.4.20 base

