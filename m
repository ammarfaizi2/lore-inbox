Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132338AbREEHRg>; Sat, 5 May 2001 03:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132392AbREEHR1>; Sat, 5 May 2001 03:17:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33809 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132338AbREEHRY>; Sat, 5 May 2001 03:17:24 -0400
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
To: john@grulic.org.ar (John R Lenton)
Date: Sat, 5 May 2001 08:20:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010505034357.A604@grulic.org.ar> from "John R Lenton" at May 05, 2001 03:43:57 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vwN7-0000J4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > one of them to a new mb with a non-VIA chipset (Asus A7A266), and it boot=
> ed the
> > first Athlon kernel I tried (2.4.4).  No other changes to .config, same
> > processor as before, same memory, same disks, same video, same case, same=
>  power
> > cord, you name it.
> 
> damn. I guess the saving of 200$ on the MSI has probably been
> 300$ down the drain :(

Dont panic just yet. Manfred's observation could mean we hit chipset specific 
behaviour on prefetches. 
