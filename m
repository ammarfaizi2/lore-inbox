Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314758AbSECQv7>; Fri, 3 May 2002 12:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314761AbSECQv6>; Fri, 3 May 2002 12:51:58 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:33851 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S314758AbSECQv5>;
	Fri, 3 May 2002 12:51:57 -0400
Date: Fri, 3 May 2002 18:51:56 +0200 (CEST)
From: Krzysiek Taraszka <dzimi@ep09.kernel.pl>
To: Tom Rini <trini@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PPC and 2.2.21rc3 with modular ide subsystem
In-Reply-To: <20020503164358.GC894@opus.bloom.county>
Message-ID: <Pine.LNX.4.44.0205031851010.29050-100000@ep09.kernel.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002, Tom Rini wrote:

> Date: Fri, 3 May 2002 09:43:58 -0700
> From: Tom Rini <trini@kernel.crashing.org>
> To: Krzysiek Taraszka <dzimi@ep09.kernel.pl>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: PPC and 2.2.21rc3 with modular ide subsystem
> 
> On Fri, May 03, 2002 at 06:05:34PM +0200, Krzysiek Taraszka wrote:
> > On Fri, 3 May 2002, Tom Rini wrote:
> > 
> > > Date: Fri, 3 May 2002 08:53:13 -0700
> > > From: Tom Rini <trini@kernel.crashing.org>
> > > To: Krzysiek Taraszka <dzimi@ep09.kernel.pl>
> > > Cc: linux-kernel@vger.kernel.org
> > > Subject: Re: PPC and 2.2.21rc3 with modular ide subsystem
> > > 
> > > On Fri, May 03, 2002 at 01:58:49PM +0200, Krzysiek Taraszka wrote:
> > > 
> > > > I tried compile 2.2.21rc3 with modular ide subsystem and i got that 
> > > > messages:
> > > 
> > > Pmac IDE is not able to be built as a module.  If you just have a PCI
> > > IDE card you want to use, you should be able to if you set
> > > CONFIG_BLK_DEV_IDE_PMAC to n.  Otherwise you must compile it in.
> > 
> > What about 2.4/2.5 kernels ? 
> 
> The same restrictions apply to 2.4 as well.  It's planned to try and fix
> this issue in 2.5 at some point.

Thank you very much.

Krzysiek Taraszka			(dzimi@pld.org.pl)

