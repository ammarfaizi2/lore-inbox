Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286752AbRLVKYz>; Sat, 22 Dec 2001 05:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286753AbRLVKYi>; Sat, 22 Dec 2001 05:24:38 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:64220 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S286752AbRLVKYZ>;
	Sat, 22 Dec 2001 05:24:25 -0500
Date: Sat, 22 Dec 2001 11:24:17 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Bernd Eckenfels <usenet2001-12@lina.inka.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
In-Reply-To: <E16H9C4-0005ST-00@sites.inka.de>
Message-ID: <Pine.GSO.4.30.0112221113120.2091-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please NO NO NO NO!!

Why on earth is it good to develop misunderstandings and inconsistency
with well- and widely-known historical abbrevs?

I (and I think I'm far not alone) would hate to see those abbrevs. I
really don't want to vomit every time I read configure.help or an
ifconfig output.


This is a 3-year old decision, and haven't seen it in use anywhere before.
If this knew style would be the common use in IT, then this change is OK.
But _not_ now. (and hopefully never).

So may I suggest considering this change a few years later, _if_ it comes
into common use?

On Thu, 20 Dec 2001, Bernd Eckenfels wrote:

> In article <200112201721.KAA05522@tstac.esa.lanl.gov> you wrote:
> > Eric has decided to follow the following standard:
> > IEC 60027-2, Second edition, 2000-11,
> > Letter symbols to be used in electrical technology -
> > Part 2: Telecommunications and electronics.
> > and has changed all the abbreviations for Kilobyte (KB) to KiB,
> > Megabyte (MB) to MiB, etc, etc.
>
> I did this for nettools (i.e. ifconfig), too:
>
>           RX bytes:2120660294 (1.9 GiB)  TX bytes:341183013 (325.3 MiB)
>
> man page:
>
>        Since net-tools 1.60-4 ifconfig is printing byte  counters
>        with  SI  units. So 1 KiB are 2^10 byte. Note, the numbers
>        are truncated to one decimal (which can by quite  a large
>        error if you consider 0.1 PiB is 112.589.990.684.262 bytes :)
> ...
> SEE ALSO
>        route(8), netstat(8), arp(8), rarp(8), ipchains(8)
>        http://physics.nist.gov/cuu/Units/binary.html  -  Prefixes
>        for binary multiples
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
pozsy

