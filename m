Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313128AbSECNyF>; Fri, 3 May 2002 09:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313131AbSECNyE>; Fri, 3 May 2002 09:54:04 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19465 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313128AbSECNyD>; Fri, 3 May 2002 09:54:03 -0400
Subject: Re: 2.4.19-pre8 IDE still broken
To: jarausch@igpm.rwth-aachen.de
Date: Fri, 3 May 2002 15:13:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
In-Reply-To: <200205031343.PAA53310@numa1.igpm.rwth-aachen.de> from "jarausch@igpm.rwth-aachen.de" at May 03, 2002 03:43:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173do2-0006QF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> on 2.4.19-pre3 till 2.4.19-pre8 I get
> ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
> hdd: lost interrupt  (that is the ZIP drive)
> 
> Serverworks OSB4 in impossible state
> Disable UDMA ....

There are a few wrinkles to iron out on the serverworks side yet.
