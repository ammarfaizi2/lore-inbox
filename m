Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271239AbRH2M5t>; Wed, 29 Aug 2001 08:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271957AbRH2M5j>; Wed, 29 Aug 2001 08:57:39 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:46610 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S271239AbRH2M53>;
	Wed, 29 Aug 2001 08:57:29 -0400
Date: Wed, 29 Aug 2001 14:57:44 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: linux 2.4.9 make menuconfig bug
To: ankry@green.mif.pg.gda.pl
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3B8CE6C8.ED4F163B@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <200108291207.f7TC7SQ06387@sunrise.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz wrote:
> 
> "David Balazic wrote:"
> > kernel 2.4.9
> >
> > make menuconfig
> > on menu point "Fusion MPT device support" "Select" does nothing !
> > it should go into a submenu
> 
> Normal behaviour for empty menu.
> 
> All "fusion" options depend on CONFIG_SCSI and CONFIG_BLK_DEV_SD.

But if empty then it should no be listed at all, no ?
That would make more sense IMHO.

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
