Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285147AbRLXQSO>; Mon, 24 Dec 2001 11:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285148AbRLXQSF>; Mon, 24 Dec 2001 11:18:05 -0500
Received: from jalon.able.es ([212.97.163.2]:3776 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S285147AbRLXQRx>;
	Mon, 24 Dec 2001 11:17:53 -0500
Date: Mon, 24 Dec 2001 17:19:54 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Astinus <Astinus@netcabo.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WHICH MACHINE?????
Message-ID: <20011224171954.A2539@werewolf.able.es>
In-Reply-To: <m16IMMg-0005khC@gherkin.frus.com> <002a01c18c85$30136140$d500a8c0@mshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <002a01c18c85$30136140$d500a8c0@mshome.net>; from Astinus@netcabo.pt on Mon, Dec 24, 2001 at 15:13:35 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First of all, merry Christmas to everybody !!

On 20011224 Astinus wrote:
>
>I talked to some guys, and came up with this machine:
>

Disclaimer: obviously, this are just my humble ideas...

>        Motherboard => Intel D850GB Al ( with network and sound )

Unless you plan to plug a ton of pci cards and run out of slots, do not
buy anything integrated. If something breaks, your entire box goes to hell,
instead of unplugging your sound card and sendin it to repair (or to trash...)
Do not know about Intel's mobos, but I like SuperMicro's. I have an oldie
(a P6DGU, 400GX, and it runs more stable than anything I have tested - well,
recently we bought some 370DLE with SeverWorks HE-LS and they look fine also).
Apart from the UDE UDMA issue with ServerWorks, nowadays I would reccommend
those, a SuperMicro with LE chipset. And I will never even look at a Via.
I have only suffered with them.

>        Processor => Intel P4 2 GHz

I do not follow the MHz war, but that sounds the latest-and-greatest-and-
heatsink-burning. Do you really need it ? Think of a one of those new
1.2-1.3GHz Tualatins. They look like halfway a PIII and a Xeon. Save money
on the processor and invest it on the mobo. I will tell you to look at
the cache amount, but nowadays processor manufacturers are trading MHz
for cache. Brute force instead of cleverness...

>        Hard Drive => Seagate SCSI Cheata 10 000 rmp ( i think it is written
>like this: Cheata ) with 16 megs of cache
>        Scsi controler => adaptec scsi ultra 160 whith two channels

I have dealed with IBMs and Fujitsus. IBMs get my vote.
(btw, I think it's spelled 'cheeta', like the panthers...)

>        Ram => 1000 mb ram 2x 512 rims

Those SuperMicro I talked about allow 2 (and perjaps 4) way interleaving
with DIMM (133). They run fast, very fast...

>        Video card => (haven't decided but probably a geforce 2 with 64 mb
>ram )
>

If you do not plan a very heavy 3D, a GeForce2MX400 is the best price-feature
rate. The highest of the low-end. I think they are changing it now for some
called Titanium.

>Well these are the main components that i am thinking to use for building a
>new machine.
>
>I would like u to tell me if it is a good choice, or if i should buy a dual
>xenon processor machine instead.....
>

A dual box will feel much more responsive for interactive work, even if the
processors are not too fast. I have 2 PII@400MHz (yes, PII, did not loose
a I), and the box runs smoother than some GHz boxes (well, some cheating
here, the PII have 512KB caches, not like newest processors that even drop
it to 128KB).

Happy Christmas gift...

By.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.17-beo #1 SMP Sun Dec 23 01:12:10 CET 2001 i686
