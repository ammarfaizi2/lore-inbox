Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129602AbQLFR1G>; Wed, 6 Dec 2000 12:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129631AbQLFR04>; Wed, 6 Dec 2000 12:26:56 -0500
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:17034 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S129602AbQLFR0r>; Wed, 6 Dec 2000 12:26:47 -0500
Date: Wed, 6 Dec 2000 16:54:14 +0000 (GMT)
From: Guennadi Liakhovetski <gvlyakh@mail.ru>
To: Andre Hedrick <andre@linux-ide.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: DMA for WDC CA21600H CCC F6 details
In-Reply-To: <Pine.LNX.4.10.10012051209310.19327-100000@master.linux-ide.org>
Message-ID: <Pine.GSO.4.21.0012061651210.7771-100000@acms23>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I just received another reply from WD (after my repeated enquiry) - now
they say my disk DOES support DMA... So, either - something is wrong with
my kernel configuration / hdparm usage / kernel boot parameters / whatever
else... OR BIOS... Which I don't know how to  bypass...

Regards
Guennadi

On Tue, 5 Dec 2000, Andre Hedrick wrote:

> Did you set the autodma kernel flag?
> If not pass ide0=dma and ide1=dma.
> Also you need to enable the PIIX_TUNING
> 
> Cheers,

___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, U.K.
email: G.Liakhovetski@sheffield.ac.uk


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
