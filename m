Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281719AbRLLSC1>; Wed, 12 Dec 2001 13:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281748AbRLLSCS>; Wed, 12 Dec 2001 13:02:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22543 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281735AbRLLSCJ>; Wed, 12 Dec 2001 13:02:09 -0500
Subject: Re: Repost: ASUS APM Problem (ASUS L8400L & ASUS P2B-F)
To: fridtjof@fbunet.de (Fridtjof Busse)
Date: Wed, 12 Dec 2001 18:11:38 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20011212174754.5A2DA73D5E@merlin.fbunet.de> from "Fridtjof Busse" at Dec 12, 2001 06:47:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16EDr0-0001vc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wednesday, 12. December 2001 16:59, Alan Cox wrote:
> > > $ cat /proc/apm
> > > 1.14 1.2 0x03 0x01 0xff 0x80 -1% -1 ?
> > >                              ^^^^^^^^
> >
> > -1 is "unknown"
> 
> Is there any way to get this working?

It is working. The BIOS doesn't support that information.
