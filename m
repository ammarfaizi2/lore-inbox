Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267221AbTBDLDY>; Tue, 4 Feb 2003 06:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267222AbTBDLDX>; Tue, 4 Feb 2003 06:03:23 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:14739
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267221AbTBDLDX>; Tue, 4 Feb 2003 06:03:23 -0500
Subject: Re: suspect bug in patch-2.4.21-pre*
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Darkness <darkness@hacari.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200302032354.14167.darkness@hacari.org>
References: <200302032354.14167.darkness@hacari.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044360582.23312.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 04 Feb 2003 12:09:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 22:54, Darkness wrote:
> Hi.
> After patching the official kernel 2.4.20 with patch-2.4.21-pre2 or 
> patch-2.4.21-pre3 or patch-2.4.21-pre4 I had problems with
> my dvd rom (SAMSUNG DVD-ROM SD-616), I can't mount data-cd and I can't see
> the dvds. Therefore I have removed the patch and all it works well.

Disable DMA for CD devices and let me know what occurs. Also include "dmesg" data

