Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287139AbSAXKcu>; Thu, 24 Jan 2002 05:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286962AbSAXKck>; Thu, 24 Jan 2002 05:32:40 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:20609 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S286942AbSAXKcf> convert rfc822-to-8bit; Thu, 24 Jan 2002 05:32:35 -0500
Date: Thu, 24 Jan 2002 11:32:30 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: timothy.covell@ashavan.org, Vojtech Pavlik <vojtech@suse.cz>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <200201232321.AAA02845@rzmail.uni-trier.de>
Message-ID: <Pine.LNX.4.40.0201241125220.6687-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Dieter [iso-8859-15] Nützel wrote:

> CPU		23-25°C	(with IDLE and BUS GRANT)
> system (case)	20-23°C	(room temperature)

hmmm ... my system is at 33 case and 34-35 cpu temperature (°C) when it is
idle ... this are not so bad temperatures ... it has temperature
controlled fans which only reach their maximum spin at around 40-45 ... so
the system is not so good coold when it is cooler but produce lesser noise
...

> At any time (full load) the case temperature shouldn't go over 40°C with all
> stuff running (gfx, disks, lan, etc.). Recommendations from AMD and Intel.

yes ... the case temp should not go over 40°C but the cpu  is fine if it
is under 45-50°C under load.

> > I've come to the conclusion that the lm_sensors stuff is crap,
>
> No, they have the frame work in place but need the usefull bits.
> That's we are hunting for...

the lm_sensors package is realy fine ... it was a realy usfull tool when i
was tweaking on this patch ...

> > but not totally because of the authors.  It looks like the manufacturers
> > like VIA are not very helpful to the project.....
>
> Very true!

i get my informations from pcr files for wpcredit ... a editor to
manipulate the chipset and bios settign from within windows. this pcr
files contains the adresses for some usefull registers and such things ...

daniel

# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

