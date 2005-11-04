Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbVKDNIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVKDNIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 08:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbVKDNIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 08:08:10 -0500
Received: from [81.2.110.250] ([81.2.110.250]:64678 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751232AbVKDNIJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 08:08:09 -0500
Subject: Re: Parallel ATA with libata status with the patches I'm working on
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
In-Reply-To: <20051104013054.GF3469@ime.usp.br>
References: <1131029686.18848.48.camel@localhost.localdomain>
	 <20051103144830.GF28038@flint.arm.linux.org.uk>
	 <58cb370e0511030702hb06a5f3qc2dfe465ee1d784c@mail.gmail.com>
	 <m3oe51zc2e.fsf@defiant.localdomain>
	 <58cb370e0511031329h7532259y6d3624fbf2d93f88@mail.gmail.com>
	 <1131058464.18848.94.camel@localhost.localdomain>
	 <20051104013054.GF3469@ime.usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Fri, 04 Nov 2005 13:38:12 +0000
Message-Id: <1131111492.26925.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-03 at 23:30 -0200, Rogério Brito wrote:
> On Nov 03 2005, Alan Cox wrote:
> > Still I've done atiixp, opt621 and it8172 this afternoon. 
> 
> Do you want a guinea pig? I have a system with an Asus A7V motherboard
> (with both via82xxxx and PDC20265 controllers) and also a notebook with
> a 440BX/ZX chipset.
> 
> I'm willing to trash some installations of mine.
> 
> Hope this helps if you're looking for stupid^w^w^w^w^w^wbrave users. :-)


Let me get the patches cleaned up and in order start of next week and
I'd be glad of testers. Especially if a 2.6.14-mm1 appears so I've got
something nice to diff against 8)

Alan

