Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135765AbRAJPFQ>; Wed, 10 Jan 2001 10:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135764AbRAJPFH>; Wed, 10 Jan 2001 10:05:07 -0500
Received: from ns.sysgo.de ([213.68.67.98]:1277 "EHLO dagobert.svc.sysgo.de")
	by vger.kernel.org with ESMTP id <S135312AbRAJPE4>;
	Wed, 10 Jan 2001 10:04:56 -0500
Date: Wed, 10 Jan 2001 16:04:34 +0100 (MET)
From: Robert Kaiser <rob@sysgo.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: richardj_moore@uk.ibm.com, Tom Leete <tleete@mountain.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Anybody got 2.4.0 running on a 386 ?
In-Reply-To: <E14GM64-0000Kc-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0101101559230.19382-100000@dagobert.svc.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2001, Alan Cox wrote:

> > Does linux cater of all the old 386 chip bugs - especially the memory
> > management oddities?
> 
> So called 'sigma sigma' 386 and higher. Ie we dont support the 386 with the
> 32bit mul bugs.

Is this a new thing in 2.4.0 ? Could it possibly cause a crash as
early as pagetable_init() ?

----------------------------------------------------------------
Robert Kaiser                          email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14
D-55270 Klein-Winternheim / Germany    fax:   (49) 6136 9948-10

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
