Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbTAJUzC>; Fri, 10 Jan 2003 15:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbTAJUzC>; Fri, 10 Jan 2003 15:55:02 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:56849
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S266006AbTAJUzA>; Fri, 10 Jan 2003 15:55:00 -0500
Date: Fri, 10 Jan 2003 12:48:28 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Manish Lachwani <m_lachwani@yahoo.com>,
       Manish Lachwani <manish@Zambeel.com>
cc: linux-kernel@vger.kernel.org, Michael.Knigge@set-software.de
Subject: Re: FW: Fastest possible UDMA - how?
In-Reply-To: <20030110190403.2127.qmail@web20510.mail.yahoo.com>
Message-ID: <Pine.LNX.4.10.10301101234390.31168-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I guess if Google can publish their patches to the driver they ship,
Zambeel should consider publishing the known changes they ship with
products.  Zambeel should decide if it is going to contribute or just
take.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 10 Jan 2003, Manish Lachwani wrote:

> Take a look at the drive IDENTIFY data. From the ATA
> spec, it can be seen that word# 88 in the IDENTIFY
> data can help you find out the UDMA mode selected and
> UDMA mode supported. 
> 
> The UDMA mode supported is the maximum supported by
> the drive. 
> 
> Thanks
> Manish
> 
> > Hi all,
> > 
> > is it somehow possible to determine what is the
> > fastest UDMA-Mode my 
> > IDE-Controller supports - independant of the
> > chipset?
> > 
> > Thanks,
> >   Michael
> > 
> > 
> > 
> > -
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 
> __________________________________________________
> Do you Yahoo!?
> Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
> http://mailplus.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

