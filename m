Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264714AbSKIMmu>; Sat, 9 Nov 2002 07:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264722AbSKIMmu>; Sat, 9 Nov 2002 07:42:50 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:51358 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264714AbSKIMmu>; Sat, 9 Nov 2002 07:42:50 -0500
Subject: Re: [PATCH] SCSI on non-ISA systems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Rusty Trivial Russell <trivial@rustcorp.com.au>
In-Reply-To: <20021109005344.A26065@infradead.org>
References: <20021108135742.A22790@flint.arm.linux.org.uk>
	<Pine.GSO.4.21.0211081522050.23267-100000@vervain.sonytel.be>
	<20021108144234.A24114@flint.arm.linux.org.uk>
	<1036772421.16651.10.camel@irongate.swansea.linux.org.uk> 
	<20021109005344.A26065@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Nov 2002 13:13:05 +0000
Message-Id: <1036847585.20393.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-09 at 00:53, Christoph Hellwig wrote:
> No.  I restructured the BHA interfaces to get rid of ->detect and
> ->release.  Makeing it mandatory is a step backwards.  Not having a
> default fallback is a good idea, though.

That IMHO is not a 2.6 change

