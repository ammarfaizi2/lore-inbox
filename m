Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310520AbSCKRkV>; Mon, 11 Mar 2002 12:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310518AbSCKRkL>; Mon, 11 Mar 2002 12:40:11 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:14089 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S310520AbSCKRkD>; Mon, 11 Mar 2002 12:40:03 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200203111739.SAA23452@green.mif.pg.gda.pl>
Subject: Re: IDE on linux-2.4.18 (fwd)
To: ankry@pg.gda.pl (Andrzej Krzysztofowicz)
Date: Mon, 11 Mar 2002 18:39:58 +0100 (CET)
Cc: linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <200203111736.g2BHavN17745@sunrise.pg.gda.pl> from "Andrzej Krzysztofowicz" at Mar 11, 2002 06:36:59 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 11 Mar 2002, Alan Cox wrote:
> 
> > > hda: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=1024/255/63, UDMA(33)
> > > Partition check:
> > >  hda: hda1 hda2 < hda5 hda6 >
> > > hd: unable to get major 3 for hard disk
> > 
> > ^^^^^^^^^^^^^^^^^^
> > 
> > Case dismissed ;)
> 
> I haven't a clue what you are saying. Every IDE option that is allowed
> is enabled in .config. The IDE drive(s) are found, but you imply, no
> state, that I did something wrong. You state that I haven't enabled
> something? I enabled everything that 'make config` allowed me to
> enable. Now what is it?

You are lucky that your IDE disk works. It should not as you choosed to use
"Old driver on the first channel". 

RTFM.

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
