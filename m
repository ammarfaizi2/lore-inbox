Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTADVrK>; Sat, 4 Jan 2003 16:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbTADVrK>; Sat, 4 Jan 2003 16:47:10 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15233
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261530AbTADVrJ>; Sat, 4 Jan 2003 16:47:09 -0500
Subject: Re: [PATCHSET] Multiarch kconfig cleanup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
In-Reply-To: <Pine.GSO.4.21.0301042122590.10261-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0301042122590.10261-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041719964.2555.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 04 Jan 2003 22:39:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-04 at 20:24, Geert Uytterhoeven wrote:
> > 
> > If I had my druthers, I would s/pcnet_cs/ne2k_cs/ too...  hmmmmmm  :)
> 
> And I guess you want to rename mac8390 (which just got renamed from daynaport
> :-) to ne2k-nubus, too?

8390 is the better name. ne2000 and ne/2 are specific product names.

