Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290297AbSAXVBB>; Thu, 24 Jan 2002 16:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290294AbSAXVAv>; Thu, 24 Jan 2002 16:00:51 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:60584 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S290297AbSAXVAg>; Thu, 24 Jan 2002 16:00:36 -0500
Date: Thu, 24 Jan 2002 22:00:33 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Ed Sweetman <ed.sweetman@wmich.edu>
cc: Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Norbert Preining <preining@logic.at>, <linux-kernel@vger.kernel.org>
Subject: Re: amd athlon cooling on kt266/266a chipset
In-Reply-To: <1011874755.22707.17.camel@psuedomode>
Message-ID: <Pine.LNX.4.40.0201242158140.9957-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jan 2002, Ed Sweetman wrote:

> You should check your /var/log/messages directly for this nifty little
> message.
> kernel: ACPI: APM is already active, exiting
>
> If you compiled in apm at the time you did that test,  acpi wasn't even
> active and thus the special athlon disconnect patch wasn't even
> working.   So all of that better cooling would be psychoschomatic.
> Wouldn't be the first time better cooling/performance was all in the
> head of the person using the hardware...although if you didn't have apm
> compiled in then none of this matters and it was all working. But i
> doubt that is true due to the 42C idle after some use no matter which
> kernel was being used.

for the test i build a new kernel without any acpi function but with apm
ompiled in ... if you mean this ... the results where those i posted ...

> Furthermore, I haven't heard of anyone where the patch actually makes an
> improvement in temp with the patch.  But i have heard of people saying
> it affected performance detrimentally. If it is helping and the cpu fans
> decrease due to the lower temp, add fan speeds in different loads/temps
> to reflect this.
> lowering the fan speed and thus noise is more than a welcome change.

my cpu is cooled down and my cpu fan + 2 temperature controlled case fans
are slowed down -> lesser noise ...

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

