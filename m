Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276034AbRJBRTn>; Tue, 2 Oct 2001 13:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276044AbRJBRTe>; Tue, 2 Oct 2001 13:19:34 -0400
Received: from gateway.wvi.com ([204.119.27.10]:2542 "HELO gateway.wvi.com")
	by vger.kernel.org with SMTP id <S276040AbRJBRTS>;
	Tue, 2 Oct 2001 13:19:18 -0400
Message-ID: <3BB9F72F.C35F724B@wvi.com>
Date: Tue, 02 Oct 2001 10:19:44 -0700
From: Jim Potter <jrp@wvi.com>
X-Mailer: Mozilla 4.75 (Macintosh; U; PPC)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@aslab.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: ASL Presents UltraDMA 133 and 160GB drive support in Linux!
In-Reply-To: <Pine.LNX.4.31.0109271829470.23925-100000@postbox.aslab.com>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know where to get Andre's code for the PDC20269?


> PDC20269: IDE controller on PCI bus 02 dev 20
> PDC20269: chipset revision 2
> PDC20269: not 100% native mode: will probe irqs later
> PDC20269: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
>     ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
> hde: Maxtor 4G160H8, ATA DISK drive
> ide2 at 0xa000-0xa007,0xa402 on irq 11
> hde: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=317632/255/63, UDMA(133)
>
> Linux wins again in the support world.
>
> Andre Hedrick
> CTO ASL, Inc.
> Linux ATA Development
> -----------------------------------------------------------------------------
> ASL, Inc.                                    Tel: (510) 857-0055 x103
> 38875 Cherry Street                          Fax: (510) 857-0010
> Newark, CA 94560                             Web: www.aslab.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
Sincerely,

Jim Potter
45th Parallel Processing
jrp@wvi.com

"It is rather for us to be here dedicated to the great
task remaining before us -- that from these honored dead
we take increased devotion to that cause for which they
gave the last full measure of devotion -- that we here
highly resolve that these dead shall not have died in vain,
that this nation under God shall have a new birth of
freedom, and that government of the people, by the people,
for the people shall not perish from the earth.

A. Lincoln, Gettysburg, 1863

ln -sf /dev/null /osama/bin/laden


