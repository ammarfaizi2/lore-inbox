Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSIDXcb>; Wed, 4 Sep 2002 19:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316446AbSIDXcb>; Wed, 4 Sep 2002 19:32:31 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:13814
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316430AbSIDXca>; Wed, 4 Sep 2002 19:32:30 -0400
Subject: Re: 3 ultra100 controllers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: "T. Ryan Halwachs" <halwachs@cats.ucsc.edu>,
       kernel mailing list <linux-kernel@vger.kernel.org>,
       ataraid mailing list <ataraid-list@redhat.com>,
       Jeff Nguyen <jeff@aslab.com>
In-Reply-To: <Pine.LNX.4.10.10209041245300.3440-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10209041245300.3440-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 05 Sep 2002 00:36:29 +0100
Message-Id: <1031182589.2796.141.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-04 at 20:48, Andre Hedrick wrote:
> 5 have been done!
> 
> Ask "Jeff Nguyen", all it means is that only two cards will be setup by
> their BIOS.  The remaining cards will be setup by the driver.
> IIRC, there was a special RIO version with 8 card or 32 drives.

I wouldnt like to see the performance of the resulting box or try it on
a VIA chipset or anything else I didn't trust 100% to handle contention
on the PCI bus

