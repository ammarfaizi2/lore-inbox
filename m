Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287488AbSBUXQR>; Thu, 21 Feb 2002 18:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287493AbSBUXQH>; Thu, 21 Feb 2002 18:16:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21775 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287488AbSBUXPx>;
	Thu, 21 Feb 2002 18:15:53 -0500
Message-ID: <3C757FA7.BFD51A03@mandrakesoft.com>
Date: Thu, 21 Feb 2002 18:15:51 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: eepro100 (was Re: Linux 2.4.18-rc3)
In-Reply-To: <E16e2aJ-00007x-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > eepro100 users,
> >
> > If you can spare some time, please test and compare 2.4.17 and
> > 2.4.18-rc3 kernel versions, for (a) regressions in performance/behavior,
> > and (b) -fixed- or improved behavior.
> 
> Just glancing over the code - shouldnt it use pci_enable device before
> checking the regions its assigned ?
> 
> Also it seems to include linux/delay.h twice

indeed, thanks..

-- 
Jeff Garzik      | XXX FREE! secure AFSPC AK-47 unclassified CDC
Building 1024    | NATO SAS CDMA fun with filters Bellcore kibo SSL
MandrakeSoft     | high security goat clones infowar 2600 Magazine
