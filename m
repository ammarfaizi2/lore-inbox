Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSGRAIn>; Wed, 17 Jul 2002 20:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSGRAIn>; Wed, 17 Jul 2002 20:08:43 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:26129 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S315266AbSGRAIk>; Wed, 17 Jul 2002 20:08:40 -0400
Date: Wed, 17 Jul 2002 20:17:47 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>, Klaus Dittrich <kladit@t-online.de>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19rc2 and Promise RAID controller
In-Reply-To: <1026937029.1688.160.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207172017280.25929-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Klaus,

Could you please set CONFIG_PDC202XX_FORCE to on and see what happens?

On 17 Jul 2002, Alan Cox wrote:

> On Wed, 2002-07-17 at 17:54, Andre Hedrick wrote:
> >
> > This is just proves that accepting the patch code from Promise will begin
> > to remove basic support for hardware.  I warned everyone of this and
> > people do not listen.  So I suggest that you find another vendors product
> > to use as the PDC20270 shall not be supported anymore.
>
> Andre, this is not the case. We all agreed to sort out the raid detect.
> I sent Marcelo a diff and some instructions. He applied the diff but I
> guess my instructions were too confusing. It'll get fixed for -rc3
>
> If you want a conspiracy to play with look elsewhere (there are no
> shortage of real ones 8))
>

