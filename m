Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbTKFEL4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 23:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263339AbTKFEL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 23:11:56 -0500
Received: from drifthost.com ([66.28.242.251]:49116 "EHLO drifthost.com")
	by vger.kernel.org with ESMTP id S263340AbTKFELx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 23:11:53 -0500
Message-ID: <1951.61.88.244.7.1068091810.squirrel@mail.drifthost.com>
Date: Thu, 6 Nov 2003 15:10:10 +1100 (EST)
Subject: Re: no DRQ after issuing WRITE
From: <steve@drifthost.com>
To: <Robert.L.Harris@rdlg.net>
In-Reply-To: <20031106032133.GD19875@rdlg.net>
References: <200311042029.38749.andy@asjohnson.com>
        <1805.61.88.244.7.1068001546.squirrel@mail.drifthost.com>
        <01ba01c3a3f7$1da22100$dfb21ad3@drifthost>
        <20031106032133.GD19875@rdlg.net>
X-Priority: 3
Importance: Normal
Cc: <steve@drifthost.com>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.9)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeh im getting more of them..

Anyone know any reason why it would happen?

>
>
> No answer for you but I've gotten this message also and was hoping
> someone would know what/why...
>
>
> Thus spake Steven Adams (steve@drifthost.com):
>
>> anyone?
>> ----- Original Message -----
>> From: <steve@drifthost.com>
>> To: <linux-kernel@vger.kernel.org>
>> Sent: Wednesday, November 05, 2003 2:05 PM
>> Subject: hda: no DRQ after issuing WRITE
>>
>>
>> > Hey guys,
>> >
>> > i keep getting things like this in my dmesg
>> >
>> > ===========================================> > hda: status timeout:
>> status=0xd0 { Busy }
>> >
>> > hda: no DRQ after issuing WRITE
>> > ide0: reset: success
>> > hda: status timeout: status=0xd0 { Busy }
>> >
>> > hda: no DRQ after issuing WRITE
>> > ide0: reset: success
>> > ============================================> >
>> > From hdparm
>> > ===========================================> > /dev/hda:
>> >
>> >  Model=IC35L080AVVA07-0, FwRev=VA4OA52A, SerialNo=VNC402A4CBRJLA
>> Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>> >  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
>> >  BuffType=DualPortCache, BuffSize=1863kB, MaxMultSect=16,
>> MultSect=off CurCHS=16383/16/63, CurSects=16514064, LBA=yes,
>> LBAsects=160836480 IORDY=on/off, tPIO={min:240,w/IORDY:120},
>> tDMA={min:120,rec:120} PIO modes:  pio0 pio1 pio2 pio3 pio4
>> >  DMA modes:  mdma0 mdma1 mdma2
>> >  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
>> >  AdvancedPM=yes: disabled (255) WriteCache=enabled
>> >  Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  2 3 4 5
>> > ================================================> >
>> > Ive searched high and low to try find out what this means, all ive
>> found it people keep saying its all different kinds of things..
>> >
>> > I was wondering if this means my hdd is drying or is ti a setting?
>> >
>> > Thanks guys,
>> > Steve
>> >
>> >
>> > -
>> > To unsubscribe from this list: send the line "unsubscribe
>> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
> :wq!
> ---------------------------------------------------------------------------
> Robert L. Harris                     | GPG Key ID: E344DA3B
>                                          @ x-hkp://pgp.mit.edu
> DISCLAIMER:
>       These are MY OPINIONS ALONE.  I speak for no-one else.
>
> Life is not a destination, it's a journey.
>   Microsoft produces 15 car pileups on the highway.
>     Don't stop traffic to stand and gawk at the tragedy.



