Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbSLaAyj>; Mon, 30 Dec 2002 19:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbSLaAyi>; Mon, 30 Dec 2002 19:54:38 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:33666
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267104AbSLaAyf>; Mon, 30 Dec 2002 19:54:35 -0500
Subject: Re: Promise 20376 support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: marcel@mesa.nl
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021231000330.A21224@joshua.mesa.nl>
References: <20021230204645.B20688@joshua.mesa.nl>
	<1041281643.13615.131.camel@irongate.swansea.linux.org.uk> 
	<20021231000330.A21224@joshua.mesa.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 31 Dec 2002 01:44:45 +0000
Message-Id: <1041299085.13684.186.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-30 at 23:03, Marcel J.E. Mol wrote:
>     ide2: PDC20276 Bus-Master DMA disabled (BIOS)
>         ide3: BM-DMA at 0xec800008-0xec80000f -- ERROR, PORT ADDRESSES ALREADY IN USE

Its memory mapped I/O for one. Ok thats down to Promise providing docs
to someone I guess. Otherwise its a "winputer"


