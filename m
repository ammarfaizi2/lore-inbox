Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263968AbSLBPV1>; Mon, 2 Dec 2002 10:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262803AbSLBPV1>; Mon, 2 Dec 2002 10:21:27 -0500
Received: from bay1-f100.bay1.hotmail.com ([65.54.245.100]:42255 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id <S263968AbSLBPUT>;
	Mon, 2 Dec 2002 10:20:19 -0500
X-Originating-IP: [193.227.168.2]
From: "Elie =?ISO-8859-1?Q?Dadd=E9=22?= <ginolb89@hotmail.com>"@vax.home.local
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in alim15x3(kernel 2.4.20)
Date: Mon, 02 Dec 2002 15:27:42 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F100Vs1tIzmQVu00006414@hotmail.com>
X-OriginalArrivalTime: 02 Dec 2002 15:27:43.0039 (UTC) FILETIME=[5B8874F0:01C29A17]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey Alan
well it hangs on  both  but here  hdc  information for your request
root@ManOwaRR:/home/manowarr# hdparm -I /dev/hdc

/dev/hdc:

Model=OTHSBI AVD-DOR MDSR-1220                , FwRev=9161    , 
SerialNo=24IT112144
Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
BuffType=unknown, BuffSize=2048kB, MaxMultSect=0
(maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
PIO modes: pio0 pio1 pio2 pio3 pio4
DMA modes: mdma0 mdma1 *mdma2
AdvancedPM=no
Drive Supports : ATA/ATAPI-5 T13 1321D revision 3 : ATA-2 ATA-3 ATA-4 ATA-5

####
####

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail

