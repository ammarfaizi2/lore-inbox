Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268234AbUHQNYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268234AbUHQNYH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 09:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268225AbUHQNWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 09:22:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3286 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268222AbUHQNWL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 09:22:11 -0400
Date: Tue, 17 Aug 2004 09:25:26 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HPT374 kernel panic - regression in 2.6.8
Message-ID: <20040817122526.GD2014@logos.cnet>
References: <411DF42E.5030504@kmlinux.fjfi.cvut.cz> <1092496584.27144.3.camel@localhost.localdomain> <200408170030.45553.bzolnier@elka.pw.edu.pl> <1092693626.21067.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092693626.21067.17.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 11:00:34PM +0100, Alan Cox wrote:
> On Llu, 2004-08-16 at 23:30, Bartlomiej Zolnierkiewicz wrote:
> > http://linus.bkbits.net:8080/linux-2.5/cset@40586b50zsHhQgPLGTlje7g_f5wGTw?nav=index.html|
> > src/|src/drivers|src/drivers/ide|src/drivers/ide/pci|
> > related/drivers/ide/pci/hpt366.c
> > 
> > please read bugzilla bugs mentioned in the changelong and fix this
> 
> Already did and sent out the patch. 2.4.x is missing that small change
> so it might be a good one for Marcelo to merge ?

That and the triflex update (which I have around) we miss in 2.4 that I remember. 

I have no changelog for the triflex fixes however - can you write up please Bart?

