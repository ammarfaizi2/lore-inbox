Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWIDT7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWIDT7I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 15:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWIDT7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 15:59:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:56302 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751384AbWIDT7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 15:59:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vwt9ZHN3pX9MGqrn5KtpvcvdmD88RKaze2o/WgMer6CMEMV2rTF88RsKHqyvkFzp+LVSf2RLYlsk3Eyo/paA9iEA9hCNVcSiZYRTvEvGssc1XKFN8+Y9SF2xbbaYsD0sbc+Yb7VyuaYDMH6k7XNdWh3H740GNZrb9yApK+f9N14=
Message-ID: <625fc13d0609041259m352115b0r34b59cd2b96028af@mail.gmail.com>
Date: Mon, 4 Sep 2006 14:59:03 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Alon Bar-Lev" <alon.barlev@gmail.com>
Subject: Re: [PATCH 00/26] Dynamic kernel command-line
Cc: "Andi Kleen" <ak@suse.de>, "Matt Domsch" <Matt_Domsch@dell.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com, davej@codemonkey.org.uk, Riley@williams.name,
       trini@kernel.crashing.org, davem@davemloft.net, ecd@brainaid.de,
       jj@sunsite.ms.mff.cuni.cz, anton@samba.org, wli@holomorphy.com,
       lethal@linux-sh.org, rc@rc0.org.uk, spyro@f2s.com, rth@twiddle.net,
       avr32@atmel.com, hskinnemoen@atmel.com, starvik@axis.com,
       ralf@linux-mips.org, matthew@wil.cx, grundler@parisc-linux.org,
       geert@linux-m68k.org, zippel@linux-m68k.org, paulus@samba.org,
       schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
       uclinux-v850@lsi.nec.co.jp, chris@zankel.net
In-Reply-To: <9e0cf0bf0609032207j6471357do5b990bc4e90ea74d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609040050.13410.alon.barlev@gmail.com>
	 <625fc13d0609031801o2ecfc5eawaf5c36ae406236b8@mail.gmail.com>
	 <9e0cf0bf0609032207j6471357do5b990bc4e90ea74d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/06, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
> On 9/4/06, Josh Boyer <jwboyer@gmail.com> wrote:
> > On 9/3/06, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
> > >
> > > This patch is for linux-2.6.18-rc5-mm1 and is divided to
> > > target each architecture. I could not check this in any
> > > architecture so please forgive me if I got it wrong.
> >
> > You didn't test this on _any_ architecture?  It's a bit bold to send
> > out a patch like this without at least testing it on one architecture.
>
> I tested it on i386.
> I am truly sorry... But I don't have access to other architectures.

Oh, well that's a bit different.  Not many people have access to all
architectures, but at least you've tested it on one of them.  :)

josh
