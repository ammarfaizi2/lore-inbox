Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317504AbSFKS2L>; Tue, 11 Jun 2002 14:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317503AbSFKS2K>; Tue, 11 Jun 2002 14:28:10 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:19128 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S317501AbSFKS1M>;
	Tue, 11 Jun 2002 14:27:12 -0400
Date: Tue, 11 Jun 2002 20:26:52 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200206111826.UAA02633@harpo.it.uu.se>
To: nick@octet.spb.ru
Subject: Re: linux 2.4.19-preX IDE bugs
Cc: alan@lxorguk.ukuu.org.uk, andre@linux-ide.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002 19:31:48 +0400, Nick Evgeniev wrote:
>> > I added it to the collection of IDE oddities I'm looking at. There are
>> > also some promise requested changes due to get merged at the end of this
>> > week. Then we can see where we stand
>>
>> Also, it is hard to answer email without connectivity in the air.
>
>Agreed. But all what I see is that STABLE Linux kernel DOESN'T has working
>driver for promise controller (including latest ac patches) for SEVERAL
>MONTHS.

I don't know what your problem with the Promise driver is, but
my experience is the opposite. I have never had any problems with
the 2.4 (or 2.2 + Andre's IDE patch) pdc202xx driver and my
Ultra100 (20267) card, which sits in a 24/7 News server and
receives, stores, and sends many gigabytes of data between reboots.
(And it's only rebooted once a month or so because I prefer using
uptodate kernels. Currently running 2.4.19-pre9.)

/Mikael
