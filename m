Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268230AbTBNGY7>; Fri, 14 Feb 2003 01:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268231AbTBNGY7>; Fri, 14 Feb 2003 01:24:59 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:6416 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S268230AbTBNGY5>; Fri, 14 Feb 2003 01:24:57 -0500
Date: Thu, 13 Feb 2003 22:32:38 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Larry Hileman <LHileman@snapappliance.com>
cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "Linux Kernel \"Maillist (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: Question about 48 bit IDE on 2.4.18 kernel
In-Reply-To: <057889C7F1E5D61193620002A537E8690B5A2A@NCBDC>
Message-ID: <Pine.LNX.4.10.10302132231510.6903-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you want them back ported, you should do it your self of offer to pay
someone.

On Thu, 13 Feb 2003, Larry Hileman wrote:

> Do the 2.4.20/21 predrivers work on a 2.4.18 kernel?
> Or have they been back ported?
> 
> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Thursday, February 13, 2003 4:47 PM
> To: Larry Hileman
> Cc: Linux Kernel "Maillist (E-mail)
> Subject: Re: Question about 48 bit IDE on 2.4.18 kernel
> 
> 
> On Thu, 2003-02-13 at 23:27, Larry Hileman wrote:
> > I would expect that the CMD680 and CSB6 drivers have been updated since
> > the 2.4.18 kernel.  Can someone let me know where I can find the most
> > recent drivers.  I have checked the sources I know for the latest driver
> and
> > not had any luck.  I was hoping someone may have a better set of sources.
> 
> The 2.4.20/21predrivers support LBA48
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

