Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311650AbSCTPaX>; Wed, 20 Mar 2002 10:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311652AbSCTPaN>; Wed, 20 Mar 2002 10:30:13 -0500
Received: from mail-src.takas.lt ([212.59.31.66]:6901 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S311650AbSCTPaD>;
	Wed, 20 Mar 2002 10:30:03 -0500
Date: Wed, 20 Mar 2002 17:27:20 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re[2]: Filesystem Corruption (ext2) on Tyan S2462, 2xAMD1900MP, 2.4.17SMP
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <E16nVId-0000yr-00@the-village.bc.nu>
X-Mailer: Mahogany 0.64.2 'Sparc', compiled for Linux 2.4.18-rc4 i686
Message-ID: <ISPFE11r0dSHpVyLrid00004b63@mail.takas.lt>
X-OriginalArrivalTime: 20 Mar 2002 15:30:01.0780 (UTC) FILETIME=[1A10E740:01C1D024]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002 01:53:59 +0000 (GMT) Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > I am in their lab trying to reproduce the error and I have found some docs
> > which could help address the error of the 4byte FIFO issue in the engine.
> > It looks fixable on paper.
> 
> Andre - if you want the info I have from the previous stuff I was involved
> in I can strip out customer company info and send it on.
> 
> > As for the AMD driver, who knows which version is in that kernel.
> 
> 2.4.18 has a very old one
> 2.4.18-ac has the Andre/AMD updated one, but not the further updates.
>                 (eg it turns off SWDMA on more chipsets than it needs to)

Is AMD driver somehow related to ServerWorks OSB4?

BTW, it seems I have the same problem with Compaq ProLiant ML330, which has OSB4,
and Seagate ST320011A drives. Is turning off UDMA enough?

Regards,
Nerijus

