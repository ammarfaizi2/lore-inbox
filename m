Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbSK1H40>; Thu, 28 Nov 2002 02:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265243AbSK1H40>; Thu, 28 Nov 2002 02:56:26 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:45929
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265242AbSK1H4Z>; Thu, 28 Nov 2002 02:56:25 -0500
Date: Thu, 28 Nov 2002 03:07:09 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Mohamed El Ayouty <melayout@umich.edu>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] IDE-SCSI module corrupts further module loading on 2.5.50
In-Reply-To: <1038383730.1526.0.camel@syKr0n.mine.nu>
Message-ID: <Pine.LNX.4.50.0211280306400.14410-100000@montezuma.mastecende.com>
References: <1038383730.1526.0.camel@syKr0n.mine.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2002, Mohamed El Ayouty wrote:

> end_request: I/O error, dev hdd, sector 0
> end_request: I/O error, dev hdd, sector 0
> hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
> Uniform CD-ROM driver Revision: 3.12
> hdc: ATAPI 32X DVD-ROM drive, 512kB Cache, UDMA(33)
> end_request: I/O error, dev hdc, sector 0

Which IDE chipset do you have?

	Zwane
-- 
function.linuxpower.ca
