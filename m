Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbTADWyf>; Sat, 4 Jan 2003 17:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261693AbTADWyf>; Sat, 4 Jan 2003 17:54:35 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20353
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261660AbTADWye>; Sat, 4 Jan 2003 17:54:34 -0500
Subject: Re: [PATCHSET] Multiarch kconfig cleanup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
In-Reply-To: <Pine.GSO.4.21.0301042310210.10296-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0301042310210.10296-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041724010.2555.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 04 Jan 2003 23:46:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-04 at 22:11, Geert Uytterhoeven wrote:
> On 4 Jan 2003, Alan Cox wrote:
> > On Sat, 2003-01-04 at 20:24, Geert Uytterhoeven wrote:
> > > > If I had my druthers, I would s/pcnet_cs/ne2k_cs/ too...  hmmmmmm  :)
> > > 
> > > And I guess you want to rename mac8390 (which just got renamed from daynaport
> > > :-) to ne2k-nubus, too?
> > 
> > 8390 is the better name. ne2000 and ne/2 are specific product names.
> 
> So zorro8390 would be better than ne2k-zorro?

I think so. I bet Novell think so too 8)

